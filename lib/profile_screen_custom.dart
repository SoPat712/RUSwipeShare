// Copyright 2022, the Chromium project authors.  Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:firebase_auth/firebase_auth.dart' show ActionCodeSettings, FirebaseAuth, FirebaseAuthException, User;
import 'package:flutter/cupertino.dart' hide Title;
import 'package:flutterfire_ui/i10n.dart';
import 'package:flutter/material.dart' hide Title;
import 'package:flutterfire_ui/auth.dart';
import 'package:flutterfire_ui/src/auth/widgets/internal/loading_button.dart';

import 'package:flutterfire_ui/src/auth/widgets/internal/universal_button.dart';

import 'package:flutterfire_ui/src/auth/screens/internal/multi_provider_screen.dart';

import 'package:flutterfire_ui/src/auth/widgets/internal/rebuild_scope.dart';
import 'package:flutterfire_ui/src/auth/widgets/internal/subtitle.dart';
import 'package:flutterfire_ui/src/auth/widgets/internal/universal_icon_button.dart';

class EditButton extends StatelessWidget {
  final bool isEditing;
  final VoidCallback? onPressed;

  const EditButton({
    Key? key,
    required this.isEditing,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return UniversalIconButton(
      materialIcon: isEditing ? Icons.check : Icons.edit,
      cupertinoIcon: isEditing ? CupertinoIcons.check_mark : CupertinoIcons.pen,
      color: theme.colorScheme.secondary,
      onPressed: () {
        onPressed?.call();
      },
    );
  }
}

class EmailVerificationBadge extends StatefulWidget {
  final FirebaseAuth auth;
  final ActionCodeSettings? actionCodeSettings;
  const EmailVerificationBadge({
    Key? key,
    required this.auth,
    this.actionCodeSettings,
  }) : super(key: key);

  @override
  State<EmailVerificationBadge> createState() => _EmailVerificationBadgeState();
}

class _EmailVerificationBadgeState extends State<EmailVerificationBadge> {
  late final service = EmailVerificationService(widget.auth)
    ..addListener(() {
      setState(() {});
    })
    ..reload();

  EmailVerificationState get state => service.state;

  User get user {
    return widget.auth.currentUser!;
  }

  TargetPlatform get platform {
    return Theme.of(context).platform;
  }

  @override
  Widget build(BuildContext context) {
    if (state == EmailVerificationState.dismissed || state == EmailVerificationState.unresolved || state == EmailVerificationState.verified) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.yellow,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Subtitle(
                    text: state == EmailVerificationState.sent || state == EmailVerificationState.pending ? 'Verification email sent' : 'Email is not verified',
                    fontWeight: FontWeight.bold,
                  ),
                  if (state == EmailVerificationState.pending) ...[
                    const SizedBox(height: 8),
                    const Text(
                      'Please check your email and click the link to verify your email address.',
                    ),
                  ]
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          if (state == EmailVerificationState.pending)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                const SizedBox(width: 16),
                Wrap(
                  children: const [
                    Text('Log out and log back in to confirm.'),
                  ],
                ),
              ],
            )
          else
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (state != EmailVerificationState.sent && state != EmailVerificationState.sending)
                  UniversalButton(
                    variant: ButtonVariant.text,
                    color: Theme.of(context).colorScheme.error,
                    text: 'Dismiss',
                    onPressed: () {
                      setState(service.dismiss);
                    },
                  ),
                if (state != EmailVerificationState.sent)
                  LoadingButton(
                    isLoading: state == EmailVerificationState.sending,
                    label: 'Send verification email',
                    onTap: () {
                      service.sendVerificationEmail(
                        platform,
                        widget.actionCodeSettings,
                      );
                    },
                  )
                else
                  UniversalButton(
                    variant: ButtonVariant.text,
                    text: 'Ok',
                    onPressed: () {
                      setState(service.dismiss);
                    },
                  )
              ],
            )
        ],
      ),
    );
  }
}

class ProfileScreenCustom extends MultiProviderScreen {
  final List<Widget> children;
  final Color? avatarPlaceholderColor;
  final ShapeBorder? avatarShape;
  final double? avatarSize;
  final List<FlutterFireUIAction>? actions;
  final AppBar? appBar;
  final CupertinoNavigationBar? cupertinoNavigationBar;
  final ActionCodeSettings? actionCodeSettings;
  final Set<FlutterFireUIStyle>? styles;

  const ProfileScreenCustom({
    Key? key,
    FirebaseAuth? auth,
    List<ProviderConfiguration>? providerConfigs,
    this.avatarPlaceholderColor,
    this.avatarShape,
    this.avatarSize,
    this.children = const [],
    this.actions,
    this.appBar,
    this.cupertinoNavigationBar,
    this.actionCodeSettings,
    this.styles,
  }) : super(key: key, providerConfigs: providerConfigs, auth: auth);

  Future<bool> _reauthenticate(BuildContext context) {
    return showReauthenticateDialog(
      context: context,
      providerConfigs: providerConfigs,
      auth: auth,
      onSignedIn: () => Navigator.of(context).pop(true),
    );
  }

  List<ProviderConfiguration> getLinkedProviders(User user) {
    return providerConfigs.where((config) => user.isProviderLinked(config.providerId)).toList();
  }

  List<ProviderConfiguration> getAvailableProviders(User user) {
    return providerConfigs.where((config) => !user.isProviderLinked(config.providerId)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FlutterFireUITheme(
      styles: styles ?? const {},
      child: Builder(builder: buildPage),
    );
  }

  Widget buildPage(BuildContext context) {
    final isCupertino = CupertinoUserInterfaceLevel.maybeOf(context) != null;
    final providersScopeKey = RebuildScopeKey();
    final emailVerificationScopeKey = RebuildScopeKey();

    final user = auth.currentUser!;

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Align(
          child: UserAvatar(
            auth: auth,
            placeholderColor: Theme.of(context).colorScheme.primary,
            shape: avatarShape,
            size: avatarSize,
          ),
        ),
        Align(child: EditableUserDisplayName(auth: auth)),
        if (!user.emailVerified) ...[
          RebuildScope(
            builder: (context) {
              if (user.emailVerified) {
                return const SizedBox.shrink();
              }

              return EmailVerificationBadge(
                auth: auth,
                actionCodeSettings: actionCodeSettings,
              );
            },
            scopeKey: emailVerificationScopeKey,
          ),
        ],
        ...children,
        const SizedBox(height: 16),
        SignOutButton(
          auth: auth,
          variant: ButtonVariant.outlined,
        ),
        const SizedBox(height: 8),
      ],
    );
    final body = Padding(
      padding: const EdgeInsets.all(16),
      child: Center(
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 500) {
              return ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 500),
                child: content,
              );
            } else {
              return content;
            }
          },
        ),
      ),
    );

    Widget child = SafeArea(child: SingleChildScrollView(child: body));

    if (isCupertino) {
      child = CupertinoPageScaffold(
        navigationBar: cupertinoNavigationBar,
        child: SafeArea(
          child: SingleChildScrollView(child: child),
        ),
      );
    } else {
      child = Scaffold(
        appBar: appBar,
        body: SafeArea(
          child: SingleChildScrollView(child: body),
        ),
      );
    }

    return FlutterFireUIActions(
      actions: actions ?? const [],
      child: child,
    );
  }
}
