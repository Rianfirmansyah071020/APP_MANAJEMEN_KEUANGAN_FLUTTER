import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:manajemen_keuangan/core/constants/colors.dart';
import 'package:manajemen_keuangan/presentation/controllers/anggotas_controller.dart';
import 'package:manajemen_keuangan/presentation/controllers/anggotas_controller.dart';
import 'package:manajemen_keuangan/presentation/pages/template_page.dart';
import 'package:provider/provider.dart';

class AnggotaPage extends StatelessWidget {
  const AnggotaPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AnggotasController(),
      child: Consumer<AnggotasController>(
        builder: (context, controller, _) {
          return TemplatePage(
            title: "Anggota Management",
            body: SafeArea(
              child: SingleChildScrollView(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    bool isWide = constraints.maxWidth > 800;

                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: SizedBox(
                            width: double.infinity,
                            child: Container(
                              padding: const EdgeInsets.all(10.0),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey,
                                    blurRadius: 1.0,
                                  ),
                                ],
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12),
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const Icon(
                                    FontAwesomeIcons.userGroup,
                                    color: Colors.green,
                                  ),
                                  SizedBox(width: 30),
                                  Text(
                                    "Anggotas Management",
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleMedium,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: isWide
                              ? Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: constraints.maxWidth * 0.35,
                                      child: controller.isEditing
                                          ? _buildEditCard(context, controller)
                                          : _buildFormCard(context, controller),
                                    ),
                                    const SizedBox(width: 20),
                                    Expanded(
                                      child: _buildDataTableCard(
                                        context,
                                        controller,
                                      ),
                                    ),
                                  ],
                                )
                              : Column(
                                  children: [
                                    controller.isEditing
                                        ? _buildEditCard(context, controller)
                                        : _buildFormCard(context, controller),
                                    const SizedBox(height: 20),
                                    _buildDataTableCard(context, controller),
                                  ],
                                ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  /// ================================
  /// FORM CARD (INSERT)
  /// ================================
  Widget _buildFormCard(BuildContext context, AnggotasController controller) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tambah anggota",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: controller.namaAnggotaController,
                label: "nama anggota",
                hint: "Enter your nama anggota",
                icon: FontAwesomeIcons.userGroup,
                validator: (v) =>
                    v!.isEmpty ? "Nama anggota can't be empty" : null,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: controller.resetForm,
                    child: const Text(
                      "Cancel",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        final success = await controller.insertAnggota();
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("anggota saved successfully!"),
                            ),
                          );
                          controller.resetForm();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text("Failed to save anggota!"),
                            ),
                          );
                        }
                      }
                    },
                    child: const Text(
                      "Submit",
                      style: TextStyle(color: Colors.white),
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

  /// ================================
  /// EDIT CARD
  /// ================================
  Widget _buildEditCard(BuildContext context, AnggotasController controller) {
    return Card(
      color: Colors.white,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: controller.formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Edit anggota",
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 20),
              _buildTextField(
                controller: controller.namaAnggotaController,
                label: "nama anggota",
                hint: "Enter your nama anggota",
                icon: FontAwesomeIcons.userGroup,
                validator: (v) =>
                    v!.isEmpty ? "Nama anggota can't be empty" : null,
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: controller.cancelEdit,
                    child: const Text(
                      "Cancel Edit",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 10),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        final success = await controller.updateAnggota();
                        if (success) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.green,
                              content: Text("anggota updated successfully!"),
                            ),
                          );

                          controller.resetForm();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              backgroundColor: Colors.red,
                              content: Text(
                                "anggota admin@gmail.com tidak dapat diupdate!",
                              ),
                            ),
                          );
                        }
                      }
                    },

                    child: const Text(
                      "Update",
                      style: TextStyle(color: Colors.white),
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

  /// ================================
  /// DATA TABLE CARD
  /// ================================
  Widget _buildDataTableCard(
    BuildContext context,
    AnggotasController controller,
  ) {
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade300),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 300,
                  height: 35,
                  child: TextField(
                    controller: controller.searchController,
                    decoration: const InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 13),
                      labelText: "Search anggota...",
                      prefixIcon: Icon(
                        Icons.search,
                        size: 17,
                        color: Colors.grey,
                      ),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => controller.notifyListeners(),
                  ),
                ),
                const SizedBox(width: 15),
                DropdownButton<int>(
                  icon: const Icon(Icons.arrow_drop_down),
                  value: controller.rowsPerPage,
                  items: [5, 10, 20, 50].map((val) {
                    return DropdownMenuItem<int>(
                      value: val,
                      child: Text("$val"),
                    );
                  }).toList(),
                  onChanged: (val) {
                    controller.rowsPerPage = val!;
                    controller.currentPage = 0;
                    controller.notifyListeners();
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),

            FutureBuilder(
              future: controller.getAnggotas(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text("No anggotas found"));
                }

                final anggotas = snapshot.data!;

                return Column(
                  children: [
                    SizedBox(
                      width: double.infinity,

                      child: DataTable(
                        headingRowColor: MaterialStateProperty.all(
                          Colors.grey.shade200,
                        ),
                        border: TableBorder.all(color: Colors.grey.shade300),
                        columns: const [
                          DataColumn(label: Text("No")),
                          DataColumn(label: Text("nama anggota")),
                          DataColumn(label: Text("Actions")),
                        ],
                        rows: List.generate(anggotas.length, (index) {
                          final anggota = anggotas[index];
                          final rowNumber =
                              (controller.currentPage *
                                  controller.rowsPerPage) +
                              index +
                              1;
                          return DataRow(
                            cells: [
                              DataCell(
                                Center(child: Text(rowNumber.toString())),
                              ),
                              DataCell(Text(anggota.nama_anggota)),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                      onPressed: () =>
                                          controller.setEditMode(anggota),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: const Text("Delete anggota"),
                                            content: const Text(
                                              "Are you sure you want to delete this anggota?",
                                            ),
                                            actions: [
                                              TextButton(
                                                child: const Text("Cancel"),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                              ),
                                              TextButton(
                                                child: const Text("Delete"),
                                                onPressed: () async {
                                                  final success =
                                                      await controller
                                                          .deleteAnggota(
                                                            anggota.id!,
                                                          );

                                                  if (success) {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      const SnackBar(
                                                        backgroundColor:
                                                            Colors.green,
                                                        content: Text(
                                                          "anggota deleted successfully",
                                                        ),
                                                      ),
                                                    );
                                                  } else {
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      const SnackBar(
                                                        backgroundColor:
                                                            Colors.red,
                                                        content: Text(
                                                          "Failed to delete anggota",
                                                        ),
                                                      ),
                                                    );
                                                  }

                                                  Navigator.pop(context);
                                                },
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: controller.currentPage > 0
                              ? () {
                                  controller.currentPage--;
                                  controller.notifyListeners();
                                }
                              : null,
                        ),
                        Text("Page ${controller.currentPage + 1}"),
                        IconButton(
                          icon: const Icon(Icons.arrow_forward),
                          onPressed: anggotas.length == controller.rowsPerPage
                              ? () {
                                  controller.currentPage++;
                                  controller.notifyListeners();
                                }
                              : null,
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  /// ================================
  /// CUSTOM TEXTFIELD
  /// ================================
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelStyle: const TextStyle(color: Colors.grey, fontSize: 13),
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, size: 16),
        prefixIconColor: Colors.grey,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
