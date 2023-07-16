import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Employee> _employees = <Employee>[];

  late EmployeeDataSource _employeeDataSource;
  final DataGridController _controller = DataGridController();

  @override
  void initState() {
    super.initState();
    _employees = getEmployees();
    _employeeDataSource = EmployeeDataSource(employees: _employees);
  }

  List<Employee> getEmployees() {
    return [
      Employee(10001, 'James', 'Project Lead', 20000),
      Employee(10002, 'Kathryn', 'Manager', 30000),
      Employee(10003, 'Lara', 'Developer', 15000),
      Employee(10004, 'Michael', 'Designer', 15000),
      Employee(10005, 'Martin', 'Developer', 15000),
      Employee(10006, 'Newberry', 'Developer', 15000),
      Employee(10007, 'Balnc', 'Developer', 15000),
      Employee(10008, 'Perry', 'Developer', 15000),
      Employee(10009, 'Gable', 'Developer', 15000),
      Employee(10010, 'Grimes', 'Developer', 15000)
    ];
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            TextButton(
                child: const Text('Get Selection Information'),
                onPressed: () {
                  int selectedIndex = _controller.selectedIndex;
                  DataGridRow selectedRow = _controller.selectedRow!;
                  List<DataGridRow> selectedRows = _controller.selectedRows;
                  Fluttertoast.showToast(
                      msg: "selectIndex : $selectedIndex \n"
                          "selectedRow : $selectedRow \n"
                          "selectedRows : $selectedRows \n",
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.blue,
                      textColor: Colors.white,
                      fontSize: 15.0);
                  print(selectedIndex);
                  print(selectedRow);
                  print(selectedRows);
                }),
            Expanded(
              child: SfDataGrid(
                source: _employeeDataSource,
                columns: <GridColumn>[
                  GridColumn(
                    columnName: 'id',
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'ID',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'name',
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Name',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'designation',
                    width: 120,
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerLeft,
                      child: const Text(
                        'Designation',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                  GridColumn(
                    columnName: 'salary',
                    label: Container(
                      padding: const EdgeInsets.all(16.0),
                      alignment: Alignment.centerRight,
                      child: const Text(
                        'Salary',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
                controller: _controller,
                selectionMode: SelectionMode.multiple,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Employee {
  Employee(this.id, this.name, this.designation, this.salary);
  final int id;
  final String name;
  final String designation;
  final int salary;
}

class EmployeeDataSource extends DataGridSource {
  EmployeeDataSource({required List<Employee> employees}) {
    _employees = employees
        .map<DataGridRow>((e) => DataGridRow(cells: [
              DataGridCell<int>(columnName: 'id', value: e.id),
              DataGridCell<String>(columnName: 'name', value: e.name),
              DataGridCell<String>(
                  columnName: 'designation', value: e.designation),
              DataGridCell<int>(columnName: 'salary', value: e.salary),
            ]))
        .toList();
  }

  List<DataGridRow> _employees = [];

  @override
  List<DataGridRow> get rows => _employees;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
        cells: row.getCells().map<Widget>((dataGridCell) {
      return Container(
        alignment: (dataGridCell.columnName == 'id' ||
                dataGridCell.columnName == 'salary')
            ? Alignment.centerRight
            : Alignment.centerLeft,
        padding: const EdgeInsets.all(16.0),
        child: Text(dataGridCell.value.toString()),
      );
    }).toList());
  }
}
