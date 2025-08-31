import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
//import 'package:todo_application/features/history/data/models/history_model.dart';
import 'package:todo_application/feature/data/repositories/history_repository.dart';
import 'package:todo_application/feature/presentation/provider/history_provider.dart';
import 'package:todo_application/feature/presentation/widgets/history_card.dart';

class HistoryScreen extends StatefulWidget {
  final HistoryRepository historyRepository;
  const HistoryScreen({super.key, required this.historyRepository});
  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  //  late Future<List<HistoryData>> historyFuture;
  @override
  initState() {
    super.initState();
    //historyFuture = widget.historyRepository.fetchHistory();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<HistoryProvider>(context, listen: false).fetchHistory();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: Text(
          'History',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.navigate_before),
        ),
      ),

      /// Future Builder flow

      // body: FutureBuilder<List<HistoryData>>(
      //   future: historyFuture,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return const Center(child: CircularProgressIndicator());
      //     }
      //     if (snapshot.hasError) {
      //       return Center(child: Text("Error: ${snapshot.error}"));
      //     }
      //     final historyList = snapshot.data!;
      //     return ListView.builder(
      //       itemCount: historyList.length,
      //       itemBuilder: (context, index) {
      //         final history = historyList[index];
      //         return HistoryCard(data: history);
      //       },
      //     );
      //   },
      // ),

      /// Consumer flow
      body: Consumer<HistoryProvider>(
        builder: (context, historyProvider, child) {
          if (historyProvider.isLoading) {
            return Center(child: CircularProgressIndicator());
          }
          if (historyProvider.historyList.isEmpty) {
            return Center(child: Text('No History found'));
          }

          return RefreshIndicator(
            onRefresh: () {
              return historyProvider.fetchHistory();
            },
            child: ListView.separated(
              separatorBuilder: (context, index) {
                return SizedBox(
                  height:16
                );
              },
              itemCount: historyProvider.historyList.length,
              itemBuilder: (context, index) {
                final history = historyProvider.historyList[index];
                return HistoryCard(data: history);
              },
            ),
          );
        },
      ),
    );
  }
}
