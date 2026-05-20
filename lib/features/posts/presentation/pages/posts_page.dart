import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/posts_notifier.dart';

class PostsPage extends ConsumerWidget {
  const PostsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 2️⃣ Watch the PostsNotifier provider
    final postsAsync = ref.watch(postNotifierProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Posts'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: postsAsync.when(
        // 3️⃣ Data state: build the list
        data: (posts) => RefreshIndicator(
          onRefresh: () => ref.read(postNotifierProvider.notifier).refreshPosts(),
          child: ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: ListTile(
                  title: Text(
                    post.title,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(post.body),
                  leading: CircleAvatar(child: Text('${index + 1}')),
                ),
              );
            },
          ),
        ),
        // 4️⃣ Loading state
        loading: () => const Center(child: CircularProgressIndicator()),
        // 5️⃣ Error state
        error: (err, stack) => Center(
          child: Text('Error: $err'),
        ),
      ),
    );
  }
}