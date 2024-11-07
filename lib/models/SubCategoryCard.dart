import 'package:flutter/material.dart';
import '../models/subcategory.dart';
import 'package:provider/provider.dart';
import '../controllers/subcategory_controller.dart';

// Widget que exibe os detalhes de uma subcategoria em um cartão (Card)
class SubCategoryCard extends StatelessWidget {
  final SubCategory subCategory; // Subcategoria a ser exibida

  // Construtor que recebe uma subcategoria e usa o id como chave única
  SubCategoryCard({required this.subCategory})
      : super(key: ValueKey(subCategory.id));

  @override
  Widget build(BuildContext context) {
    return Card(
      // Card que envolve o ListTile, criando um visual com bordas elevadas
      child: ListTile(
        title: Text(subCategory.name), // Título exibindo o nome da subcategoria
        subtitle: Text(
          'Categoria: ${subCategory.category.name}', // Nome da categoria associada
          style: TextStyle(color: Colors.grey[600]), // Cor cinza para o texto
        ),
        // Botão de deletar subcategoria no canto direito do cartão
        trailing: IconButton(
          icon: Icon(Icons.delete), // Ícone de lixeira
          onPressed: () {
            // Ao pressionar, chama o método de remoção do SubCategoryController
            Provider.of<SubCategoryController>(context, listen: false)
                .removeSubCategory(subCategory.id);
          },
        ),
      ),
    );
  }
}