import 'package:flutter/material.dart';
import 'package:sartika_2407810040012_ujian_api/models/todo_model.dart';

class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  late Future<List<TodoModel>> _futureTodos;

  @override
  void initState(){
    super.initState();
    _futureTodos = _fetchTodos();
  }

  Future<List<TodoModel>> _fetchTodos() async {
    final url = Uri.parse("https://dummyjson.com/todos");
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List todosJson = data['todos']; 
        return todosJson.map((json) => TodoModel.fromMap(json as Map<String, dynamic>)).toList();
      } else {
        throw Exception("Gagal mengambil data Todos. Status: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception('Terjadi kesalahan koneksi atau parsing: ${e.toString()}');
    }
  }
  
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}