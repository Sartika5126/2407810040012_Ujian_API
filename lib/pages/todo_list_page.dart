import 'package:flutter/material.dart';
import 'package:sartika_2407810040012_ujian_api/models/todo_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Tugas (Todos)'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
        automaticallyImplyLeading: false, 
      ),
      body: FutureBuilder<List<TodoModel>>(
        future: _futureTodos,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  'Gagal memuat data: ${snapshot.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
              ),
            );
          } else if (snapshot.hasData) {

            final List<TodoModel> todos = snapshot.data!;

            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                final todoItem = todos[index];
                
                final isCompleted = todoItem.completed;

                final color = isCompleted ? Colors.green.shade700 : Colors.grey.shade600;
                final icon = isCompleted ? Icons.check_circle : Icons.radio_button_unchecked; 

                return ListTile(
                    title: Text(
                        todoItem.todo, 
                        style: TextStyle(
                            color: color, 
                            
                            decoration: TextDecoration.none, 
                        ),
                    ),
                    trailing: Icon(
                        icon, 
                        color: color,
                    ),
                );
              },
            );
          } else {
            return const Center(child: Text('Tidak ada data Todo.'));
          }
        },
      ),
    );
  }
}
