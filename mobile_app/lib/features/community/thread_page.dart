class ThreadPage extends StatefulWidget {
  final String title;
  const ThreadPage({super.key, required this.title});
  @override State<ThreadPage> createState() => _ThreadPageState();
}

class _ThreadPageState extends State<ThreadPage> {
  final _controller = TextEditingController();
  final _messages = <_Msg>[
    _Msg(user: 'MOD', text: 'Chào mọi người! Nhớ tôn trọng quy tắc, trao đổi vui vẻ nhé ✨', role: _Role.mod),
    _Msg(user: 'Miho', text: 'Hôm nay ôn ひらがな không?'),
    _Msg(user: 'Hana', text: 'Mình đang có quiz nhanh nè!'),
  ];
  bool jp = false; // simulate inline translate toggle

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(widget.title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 2),
          const Text('12 members • typing…', style: TextStyle(fontSize: 12, color: BBPalette.textDim))
        ]),
        actions: [IconButton(onPressed: (){}, icon: const Icon(Icons.info_outline))],
      ),
      body: Column(children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: BBSpacing.lg, vertical: BBSpacing.lg),
            itemCount: _messages.length + 1,
            itemBuilder: (ctx, i){
              if (i == 1) {
                // Inject a battle card inline
                return BattleInviteCard(
                  title: 'Clan Battle – Kana Speedrun',
                  subtitle: 'Starts in 5 min • Host @MOD',
                  onJoin: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const _MockBattleLobby())),
                );
              }
              final idx = i > 1 ? i - 1 : 0;
              final m = _messages[idx];
              return _Bubble(
                user: m.user,
                role: m.role,
                text: jp ? _fakeTranslate(m.text) : m.text,
              );
            },
          ),
        ),
        _Composer(
          controller: _controller,
          onToggleTranslate: () => setState(() => jp = !jp),
          onSend: () {
            if (_controller.text.trim().isEmpty) return;
            setState(() => _messages.add(_Msg(user: 'You', text: _controller.text.trim())));
            _controller.clear();
          },
        ),
      ]),
    );
  }

  String _fakeTranslate(String s){
    // mock VN→JP quick toggle for demo
    return 'JP> $s';
  }
}

class _Composer extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSend;
  final VoidCallback onToggleTranslate;
  const _Composer({required this.controller, required this.onSend, required this.onToggleTranslate});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(BBSpacing.lg, 6, BBSpacing.lg, BBSpacing.lg),
        child: Row(children: [
          IconButton(onPressed: onToggleTranslate, icon: const Icon(Icons.translate)),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: BBPalette.surface,
                borderRadius: BorderRadius.circular(BBRadii.xl),
                border: Border.all(color: BBPalette.purple.withOpacity(0.35), width: 1),
              ),
              child: TextField(
                controller: controller,
                decoration: const InputDecoration(
                  hintText: 'Write a message…',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
                minLines: 1,
                maxLines: 4,
              ),
            ),
          ),
          const SizedBox(width: 8),
          BBButton.primary('Send', onPressed: onSend, icon: Icons.send),
        ]),
      ),
    );
  }
}

enum _Role { user, mod, system }
class _Msg { final String user; final String text; final _Role role; _Msg({required this.user, required this.text, this.role = _Role.user}); }

class _Bubble extends StatelessWidget {
  final String user; final String text; final _Role role; const _Bubble({required this.user, required this.text, this.role = _Role.user});
  @override
  Widget build(BuildContext context) {
    final isMod = role == _Role.mod; final isSystem = role == _Role.system;
    final borderGrad = isMod
        ? const LinearGradient(colors: [BBPalette.purple, BBPalette.pink])
        : isSystem
            ? const LinearGradient(colors: [BBPalette.warning, BBPalette.pink])
            : const LinearGradient(colors: [BBPalette.pink, BBPalette.purple]);
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 6),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        CircleAvatar(radius: 16, backgroundColor: isMod ? BBPalette.purple : BBPalette.pink, child: Text(user.substring(0,1)) ),
        const SizedBox(width: 10),
        Expanded(
          child: BBCard(
            padding: const EdgeInsets.all(14),
            margin: EdgeInsets.zero,
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children:[
                Text(user, style: const TextStyle(fontWeight: FontWeight.w800)),
                const SizedBox(width: 8),
                if (isMod) _Ribbon(label: 'MOD'), if (isSystem) _Ribbon(label: 'SYSTEM', color: BBPalette.warning)
              ]),
              const SizedBox(height: 8),
              Text(text),
              const SizedBox(height: 6),
              Row(children:[
                IconButton(onPressed: (){}, icon: const Icon(Icons.favorite_border, size: 18)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.push_pin_outlined, size: 18)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.reply_outlined, size: 18)),
              ])
            ]),
          ),
        ),
      ]),
    );
  }
}

class _Ribbon extends StatelessWidget {
  final String label; final Color color; const _Ribbon({required this.label, this.color = BBPalette.purple});
  @override Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(label, style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w800)),
    );
  }
}