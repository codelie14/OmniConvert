import 'package:flutter/material.dart';
import '../../core/constants/app_constants.dart';
import '../../core/services/history_service.dart';
import '../../core/utils/file_utils.dart';
import 'package:intl/intl.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppConstants.surfaceDark,
      padding: const EdgeInsets.all(32.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Historique',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: AppConstants.textMain,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              TextButton.icon(
                onPressed: () async {
                  await HistoryService.clearHistory();
                },
                icon: const Icon(Icons.delete_sweep_rounded, color: Colors.redAccent),
                label: const Text('Effacer tout', style: TextStyle(color: Colors.redAccent)),
              )
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: HistoryService.getHistory(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
                final history = snapshot.data!;
                if (history.isEmpty) {
                  return Center(
                    child: Text(
                      'Aucun historique pour le moment',
                      style: TextStyle(color: AppConstants.textSecondary.withOpacity(0.5)),
                    ),
                  );
                }
                return ListView.separated(
                  itemCount: history.length,
                  separatorBuilder: (context, index) => const Divider(color: Colors.white10),
                  itemBuilder: (context, index) {
                    final item = history[index];
                    return ListTile(
                      leading: Icon(
                        _getIconForFormat(item['targetFormat']),
                        color: AppConstants.primaryBlue,
                      ),
                      title: Text(item['fileName'], style: const TextStyle(color: Colors.white)),
                      subtitle: Text(
                        '${item['sourceFormat'].toUpperCase()} ➔ ${item['targetFormat'].toUpperCase()} • ${item['timestamp']}',
                        style: TextStyle(color: AppConstants.textSecondary.withOpacity(0.7)),
                      ),
                      trailing: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: item['status'] == 'success' ? Colors.green.withOpacity(0.2) : Colors.red.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          item['status'].toUpperCase(),
                          style: TextStyle(
                            color: item['status'] == 'success' ? Colors.green : Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  IconData _getIconForFormat(String format) {
    if (['jpg', 'png', 'webp'].contains(format.toLowerCase())) return Icons.image;
    if (['mp4', 'mov', 'webm'].contains(format.toLowerCase())) return Icons.movie;
    if (['mp3', 'wav'].contains(format.toLowerCase())) return Icons.audiotrack;
    if (['pdf', 'docx'].contains(format.toLowerCase())) return Icons.description;
    return Icons.insert_drive_file;
  }
}
