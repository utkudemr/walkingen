import 'dart:async';

import 'package:flutter/material.dart';
import 'package:walkingen/l10n/generated/app_localizations.dart';
import 'package:walkingen/profile/profile.dart';
import 'package:walkingen/profile/profile_draft.dart';
import 'package:walkingen/profile/profile_repository.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({required this.repository, super.key});

  final ProfileRepository repository;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _height = TextEditingController();
  final _weight = TextEditingController();
  final _birthYear = TextEditingController();
  bool _loading = true;
  bool _saving = false;
  Future<void> _pendingDraftWrite = Future<void>.value();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _load();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused ||
        state == AppLifecycleState.detached) {
      unawaited(_pendingDraftWrite);
    }
  }

  Future<void> _load() async {
    try {
      final profile = await widget.repository.loadProfile();
      final draft = await widget.repository.loadDraft();
      if (!mounted) return;
      _name.text = draft?.isDisplayNamePresent == true
          ? draft!.displayName
          : profile?.displayName ?? '';
      _height.text = draft?.isHeightPresent == true
          ? draft!.height
          : profile?.heightCm.toString() ?? '';
      _weight.text = draft?.isWeightPresent == true
          ? draft!.weight
          : profile?.weightKg.toString() ?? '';
      _birthYear.text = draft?.isBirthYearPresent == true
          ? draft!.birthYear
          : profile?.birthYear.toString() ?? '';
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).profileLoadFailed),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final strings = AppLocalizations.of(context);
    try {
      await _pendingDraftWrite;
      final profile = Profile.fromInput(
        displayName: _name.text,
        height: _height.text,
        weight: _weight.text,
        birthYear: _birthYear.text,
        currentYear: DateTime.now().year,
      );
      await widget.repository.saveProfile(profile);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(strings.profileSaved)));
    } on ProfileValidationException {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(strings.profileRequired)));
    } catch (_) {
      if (!mounted) return;
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(strings.profileSaveFailed)));
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _saveDraft() {
    final draft = ProfileDraft.fromForm(
      displayName: _name.text,
      height: _height.text,
      weight: _weight.text,
      birthYear: _birthYear.text,
    );
    _pendingDraftWrite = _pendingDraftWrite.then((_) async {
      try {
        await widget.repository.saveDraft(draft);
      } catch (_) {
        // The next explicit save still reports its own persistence result.
      }
    });
    return _pendingDraftWrite;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _name.dispose();
    _height.dispose();
    _weight.dispose();
    _birthYear.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) return const Center(child: CircularProgressIndicator());
    final strings = AppLocalizations.of(context);
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _field(_name, strings.profileDisplayName),
          _field(
            _height,
            strings.profileHeight,
            keyboardType: TextInputType.number,
          ),
          _field(
            _weight,
            strings.profileWeight,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          _field(
            _birthYear,
            strings.profileBirthYear,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : Text(strings.profileSave),
          ),
        ],
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        enabled: !_saving,
        onChanged: (_) => _saveDraft(),
        keyboardType: keyboardType,
        decoration: InputDecoration(labelText: label),
        validator: (_) => null,
      ),
    );
  }
}
