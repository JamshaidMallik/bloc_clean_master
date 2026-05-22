import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/posts_bloc.dart';
import '../bloc/posts_event.dart';
import '../bloc/posts_state.dart';

class PostsPage extends StatelessWidget {
  const PostsPage({super.key});

  static const List<PostPreview> posts = [
    PostPreview(
      title: 'Designing a cleaner Flutter workflow',
      body:
          'A practical look at turning app ideas into small, focused screens that are easy to build and maintain.',
      author: 'Ayesha',
      readTime: '4 min read',
      tag: 'Flutter',
      color: Color(0xFF2563EB),
      icon: Icons.auto_awesome_rounded,
    ),
    PostPreview(
      title: 'Keeping business logic out of widgets',
      body:
          'UI becomes calmer when widgets only describe what the user sees and delegates the rest.',
      author: 'Hamza',
      readTime: '6 min read',
      tag: 'Architecture',
      color: Color(0xFF059669),
      icon: Icons.account_tree_rounded,
    ),
    PostPreview(
      title: 'Building lists that feel polished',
      body:
          'Spacing, hierarchy, empty states, and loading surfaces can make a simple feed feel production-ready.',
      author: 'Sara',
      readTime: '3 min read',
      tag: 'UI',
      color: Color(0xFFEA580C),
      icon: Icons.view_agenda_rounded,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PostsBloc()..add(const LoadPostsEvents()),
      child: const PostsView(),
    );
  }
}

class PostsView extends StatelessWidget {
  const PostsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<PostsBloc, PostsState>(
          builder: (context, state) {
            if (state is PostsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state is PostsLoaded) {
              final posts = state.posts;
              return CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                    sliver: SliverToBoxAdapter(
                      child: _PostsHeader(totalPosts: posts.length),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 14),
                    sliver: SliverToBoxAdapter(child: _SearchBar()),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                    sliver: SliverList.separated(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        return PostCard(post: posts[index], index: index + 1);
                      },
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 14);
                      },
                    ),
                  ),
                ],
              );
            }

            if (state is PostsError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}

class _PostsHeader extends StatelessWidget {
  const _PostsHeader({required this.totalPosts});

  final int totalPosts;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Posts', style: textTheme.headlineLarge),
              const SizedBox(height: 6),
              Text(
                '$totalPosts fresh reads waiting for you',
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF667085),
                ),
              ),
            ],
          ),
        ),
        IconButton.filled(
          onPressed: () {},
          icon: const Icon(Icons.refresh_rounded),
          tooltip: 'Refresh posts',
        ),
      ],
    );
  }
}

class _SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Search posts',
        prefixIcon: const Icon(Icons.search_rounded),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.tune_rounded),
          tooltip: 'Filter posts',
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
      ),
    );
  }
}

class PostCard extends StatelessWidget {
  const PostCard({super.key, required this.post, required this.index});

  final PostPreview post;
  final int index;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      elevation: 0,
      child: InkWell(
        onTap: () {},
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE6E8EF)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0F101828),
                blurRadius: 20,
                offset: Offset(0, 10),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  _PostIcon(post: post),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '#$index  ${post.tag}',
                          style: textTheme.labelLarge?.copyWith(
                            color: post.color,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(height: 3),
                        Text(
                          '${post.author} • ${post.readTime}',
                          style: textTheme.bodySmall?.copyWith(
                            color: const Color(0xFF667085),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.bookmark_border_rounded),
                    tooltip: 'Save post',
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(post.title, style: textTheme.titleMedium),
              const SizedBox(height: 8),
              Text(
                post.body,
                style: textTheme.bodyMedium?.copyWith(
                  color: const Color(0xFF475467),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  TextButton.icon(
                    onPressed: () {},
                    icon: const Icon(Icons.arrow_forward_rounded, size: 18),
                    label: const Text('Read post'),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.chat_bubble_outline_rounded,
                    size: 18,
                    color: Colors.grey.shade500,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '${index * 3}',
                    style: textTheme.bodySmall?.copyWith(
                      color: const Color(0xFF667085),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PostIcon extends StatelessWidget {
  const _PostIcon({required this.post});

  final PostPreview post;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 48,
      height: 48,
      decoration: BoxDecoration(
        color: post.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Icon(post.icon, color: post.color),
    );
  }
}

class PostPreview {
  const PostPreview({
    required this.title,
    required this.body,
    required this.author,
    required this.readTime,
    required this.tag,
    required this.color,
    required this.icon,
  });

  final String title;
  final String body;
  final String author;
  final String readTime;
  final String tag;
  final Color color;
  final IconData icon;
}
