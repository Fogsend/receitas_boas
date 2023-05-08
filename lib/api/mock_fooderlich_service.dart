import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/models.dart';

//  Serviço de simulação (mock) de receitas que obtém dados JSON de exemplo
//para simular solicitações/respostas de receitas.
class MockFooderlichService {
  // Solicitação em lote que obtém tanto as receitas de hoje quanto o feed de
  // amigos.
  Future<ExploreData> getExploreData() async {
    final todayRecipes = await _getTodayRecipes();
    final friendPosts = await _getFriendFeed();

    return ExploreData(todayRecipes, friendPosts);
  }

  // Obtenha JSON de exemplos de receitas de exploração para exibir na
  //interface do usuário.
  Future<List<ExploreRecipe>> _getTodayRecipes() async {
    // Simular tempo de espera da solicitação da API.
    await Future.delayed(const Duration(milliseconds: 1000));
    // Carregar JSON do sistema de arquivos.
    final dataString =
        await _loadAsset('assets/sample_data/sample_explore_recipes.json');
    // Decodificar para JSON
    final Map<String, dynamic> json = jsonDecode(dataString);

    // Percorrer cada receita e converter JSON para objeto ExploreRecipe..
    if (json['recipes'] != null) {
      final recipes = <ExploreRecipe>[];
      json['recipes'].forEach((v) {
        recipes.add(ExploreRecipe.fromJson(v));
      });
      return recipes;
    } else {
      return [];
    }
  }

  // Obtenha as postagens de amigos em JSON de exemplo para exibir
  //na interface do usuário.
  Future<List<Post>> _getFriendFeed() async {
    // Simular tempo de espera da solicitação da API.
    await Future.delayed(const Duration(milliseconds: 1000));
    // Carregar JSON do sistema de arquivos.
    final dataString =
        await _loadAsset('assets/sample_data/sample_friends_feed.json');
    // Decodificar para JSON
    final Map<String, dynamic> json = jsonDecode(dataString);

    // Percorrer cada postagem e converter JSON para objeto Post.
    if (json['feed'] != null) {
      final posts = <Post>[];
      json['feed'].forEach((v) {
        posts.add(Post.fromJson(v));
      });
      return posts;
    } else {
      return [];
    }
  }

  // Obtenha o JSON de exemplo da receita para exibir na interface do usuário.
  Future<List<SimpleRecipe>> getRecipes() async {
    // Simular tempo de espera da solicitação da API.
    await Future.delayed(const Duration(milliseconds: 1000));
    // Carregar JSON do sistema de arquivos.
    final dataString =
        await _loadAsset('assets/sample_data/sample_recipes.json');
    // Decodificar para JSON.
    final Map<String, dynamic> json = jsonDecode(dataString);

    // Percorra cada receita e converta JSON para objeto SimpleRecipe.
    if (json['recipes'] != null) {
      final recipes = <SimpleRecipe>[];
      json['recipes'].forEach((v) {
        recipes.add(SimpleRecipe.fromJson(v));
      });
      return recipes;
    } else {
      return [];
    }
  }

  // Carrega dados JSON de exemplo do sistema de arquivos.
  Future<String> _loadAsset(String path) async {
    return rootBundle.loadString(path);
  }
}
