import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_application/feature/presentation/provider/characters_provider.dart';

class CharacterScreen extends StatefulWidget {
  const CharacterScreen({super.key});

  @override
  State<CharacterScreen> createState() => _CharacterScreenState();
}

class _CharacterScreenState extends State<CharacterScreen> {
  final TextEditingController _searchController = TextEditingController();
  Timer? _debounce;

  @override
  void initState() {
    super.initState();

    // Load all characters initially
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CharactersProvider>(context, listen: false).fetchCharacters(query: _searchController.text);
    });

    // Add listener on search box
    _searchController.addListener(() {
      final query = _searchController.text;

      // // debounce → wait 500ms after user stops typing
      // if (_debounce?.isActive ?? false) _debounce!.cancel();
      // _debounce = Timer(const Duration(milliseconds: 500), () {
        Provider.of<CharactersProvider>(context, listen: false)
            .fetchCharacters(query: query);
      });
    //});
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.orange[700],
        title: const Text(
          'Characters',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.navigate_before),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: "Search characters...",
                filled: true,
                fillColor: Colors.orange.shade100,
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: const BorderSide(color: Colors.black),
                ),
              ),
            ),
          ),

          // List / Grid of Characters
          Expanded(
            child: Consumer<CharactersProvider>(
              builder: (context, characterProvider, child) {
                if (characterProvider.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (characterProvider.list.isEmpty) {
                  return const Center(child: Text('No Characters found'));
                }

                return GridView.builder(
                  itemCount: characterProvider.list.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                  ),
                  itemBuilder: (context, index) {
                    final character = characterProvider.list[index];
                    return Container(
                      margin: const EdgeInsets.all(8),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(16)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 6,
                            spreadRadius: 2,
                          )
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CachedNetworkImage(
                            imageUrl: character.image,
                            height: 80,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            character.name,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 14),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            character.species,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
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
}
