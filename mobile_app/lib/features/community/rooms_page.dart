class RoomsPage extends StatelessWidget {
  const RoomsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BBSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Rooms', style: BBTypo.title(context)),
          const SizedBox(height: 10),
          Expanded(
            child: ListView(
              children: [
                BBCard(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ThreadPage(title: 'Clan Sakura – General'))),
                  child: _RoomTile(title: 'Clan Sakura – General', subtitle: 'Miho: Hôm nay luyện ひらがな không? · 2m', typing: true),
                ),
                BBCard(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ThreadPage(title: 'JLPT N5 – Tips'))),
                  child: const _RoomTile(title: 'JLPT N5 – Tips', subtitle: 'Hana: Mẹo nhớ さしすせそ · 10m'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RoomTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final bool typing;
  const _RoomTile({required this.title, required this.subtitle, this.typing = false});
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Container(
        width: 42,
        height: 42,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          gradient: const LinearGradient(colors: [BBPalette.pink, BBPalette.purple]),
        ),
        child: const Icon(Icons.forum, size: 18),
      ),
      const SizedBox(width: 12),
      Expanded(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Row(children: [
            Expanded(child: Text(subtitle, style: const TextStyle(color: BBPalette.textDim)) ),
            if (typing) ...[
              const SizedBox(width: 6), _TypingDots()
            ]
          ])
        ]),
      )
    ]);
  }
}

class _TypingDots extends StatefulWidget { @override State<_TypingDots> createState() => _TypingDotsState(); }
class _TypingDotsState extends State<_TypingDots> with SingleTickerProviderStateMixin {
  late AnimationController _c;
  @override void initState(){super.initState(); _c = AnimationController(vsync:this, duration: const Duration(milliseconds: 900))..repeat();}
  @override void dispose(){_c.dispose(); super.dispose();}
  @override Widget build(BuildContext context){
    return AnimatedBuilder(
      animation: _c,
      builder: (_, __){
        final v = (_c.value * 3).floor();
        String dots = ['·  ','·· ','···'][v.clamp(0,2)];
        return Text(dots, style: const TextStyle(color: BBPalette.textDim));
      },
    );
  }
}