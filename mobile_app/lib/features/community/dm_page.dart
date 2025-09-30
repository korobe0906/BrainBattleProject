class DMPage extends StatelessWidget {
  const DMPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(BBSpacing.lg),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Direct Messages', style: BBTypo.title(context)),
        const SizedBox(height: 10),
        Expanded(
          child: ListView(children: const [
            _DMItem(name: '@Kenta', last: 'Gửi mình link quiz nhé', time: '1h'),
            _DMItem(name: '@Miho', last: 'Okie! 👍', time: '2h'),
          ]),
        )
      ]),
    );
  }
}

class _DMItem extends StatelessWidget {
  final String name; final String last; final String time; const _DMItem({required this.name, required this.last, required this.time});
  @override
  Widget build(BuildContext context) {
    return BBCard(
      child: Row(children: [
        CircleAvatar(radius: 20, backgroundColor: BBPalette.purple, child: Text(name.substring(1,2).toUpperCase())),
        const SizedBox(width: 12),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(name, style: const TextStyle(fontWeight: FontWeight.w800)),
          const SizedBox(height: 4),
          Text(last, style: const TextStyle(color: BBPalette.textDim)),
        ])),
        Text(time, style: const TextStyle(color: BBPalette.textDim))
      ]),
    );
  }
}