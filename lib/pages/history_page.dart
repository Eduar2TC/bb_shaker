import 'package:baby_shaker/Utils/game_data.dart';
import 'package:flutter/material.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final GameData gameData = GameData();

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        colorScheme: Theme.of(context).colorScheme,
        iconTheme: Theme.of(context).iconTheme,
        appBarTheme: Theme.of(context).appBarTheme,
      ),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          title: const Text(
            'History',
          ),
        ),
        body: Column(
          children: [
            Align(
              alignment: Alignment.center,
              child: Text(
                'Best time',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            Expanded(
              child: FutureBuilder<List<String>>(
                future: gameData.getGameData('gameData'),
                builder: (BuildContext context,
                    AsyncSnapshot<List<String>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  } else {
                    if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      snapshot.data!.sort((a, b) => a.compareTo(b));
                      String smallestItem = snapshot.data!.first;
                      return CustomScrollView(
                        slivers: [
                          SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (context, index) {
                                return ListTile(
                                  leading: const Icon(Icons.access_time),
                                  trailing:
                                      snapshot.data![index] == smallestItem
                                          ? const Icon(Icons.star)
                                          : null,
                                  title: Text(snapshot.data![index]),
                                  style: Theme.of(context).listTileTheme.style,
                                );
                              },
                              childCount: snapshot.data!.length,
                            ),
                          ),
                        ],
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
