import 'package:baby_shaker/Utils/game_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final GameData gameData = GameData();

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.blue,
        statusBarBrightness: Brightness.light,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(
          colorScheme: Theme.of(context).colorScheme,
          iconTheme: Theme.of(context).iconTheme,
          appBarTheme: Theme.of(context).appBarTheme,
        ),
        child: Scaffold(
          backgroundColor: Theme.of(context).colorScheme.background,
          appBar: /*AppBar(
            title: const Text(
              'History',
            ),
          )*/
              null,
          body: SafeArea(
            child: Column(
              children: [
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
                          if (snapshot.data!.isEmpty) {
                            return Center(
                              child: Container(
                                padding: const EdgeInsets.all(100),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  style: TextStyle(
                                    color: Colors.black.withOpacity(0.6),
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  'No data found',
                                ),
                              ),
                            );
                          } else {
                            List<String> sortedData =
                                List<String>.from(snapshot.data!);
                            sortedData.sort((a, b) => a.compareTo(b));
                            String smallestItem = sortedData.first;

                            return CustomScrollView(
                              slivers: [
                                SliverAppBar(
                                  pinned: true,
                                  floating: true,
                                  centerTitle: true,
                                  //automaticallyImplyLeading: false,
                                  backgroundColor: Theme.of(context)
                                      .appBarTheme
                                      .backgroundColor,
                                  title: Text(
                                    'Best time',
                                    style:
                                        Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (context, index) {
                                      return ListTile(
                                        tileColor: Colors.white,
                                        leading: const Icon(Icons.access_time),
                                        trailing: snapshot.data![index] ==
                                                smallestItem
                                            ? const Icon(Icons.star)
                                            : null,
                                        title: Text(snapshot.data![index]),
                                        style: Theme.of(context)
                                            .listTileTheme
                                            .style,
                                      );
                                    },
                                    childCount: snapshot.data!.length,
                                  ),
                                ),
                              ],
                            );
                          }
                        }
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
