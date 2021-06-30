import 'package:api_dotnet_app/app/controllers/customer_controller.dart';
import 'package:api_dotnet_app/app/models/customer_model.dart';
import 'package:api_dotnet_app/shared/services/customer_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CustomersView extends StatefulWidget {
  const CustomersView({Key? key}) : super(key: key);

  @override
  _CustomersViewState createState() => _CustomersViewState();
}

class _CustomersViewState extends State<CustomersView> {
  Future<void> _add() async {
    CustomerService(context).insert();
  }

  Future<void> _refresh() async {
    CustomerService(context).refresh();
  }

  Future<void> _edit(CustomerModel customer) async {
    CustomerService(context).edit(customer);
  }

  Future<void> _remove(CustomerModel customer) async {
    print(customer.id);
    CustomerService(context).delete(customer.id);
  }

  ListView _customerList() {
    CustomerController controller =
        Provider.of<CustomerController>(context, listen: true);

    return ListView.builder(
      itemCount: controller.count + 1,
      itemBuilder: (context, index) {
        if (index == 0) return SizedBox(height: 70);
        return Card(
          child: ListTile(
            title: Text('${controller.customers[index - 1].name}'),
            subtitle: Text('${controller.customers[index - 1].cpfCnpj}'),
            leading: CircleAvatar(
              child: Icon(Icons.person, size: 30),
            ),
            trailing: IconButton(
              onPressed: () => _remove(controller.customers[index - 1]),
              icon: Icon(Icons.delete, size: 30),
            ),
            onTap: () => _edit(controller.customers[index - 1]),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    _refresh();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Clientes'),
        actions: [
          IconButton(
            onPressed: _refresh,
            icon: Icon(Icons.refresh),
          ),
        ],
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          _customerList(),
          SearchInput(
            label: 'Filtrar',
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _add,
        child: Icon(
          Icons.add,
          size: 36,
        ),
      ),
    );
  }
}

class SearchInput extends StatefulWidget {
  final String label;

  SearchInput({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  _SearchInputState createState() => _SearchInputState();
}

class _SearchInputState extends State<SearchInput> {
  IconData icon = Icons.person;
  var filterStatus = 'active';
  TextEditingController _filterController = TextEditingController();

  Future<void> _filter(String filter) async {
    Provider.of<CustomerController>(context, listen: false).filter = filter;
  }

  @override
  void initState() {
    icon = Icons.person;
    filterStatus = 'active';
    super.initState();
  }

  Future<void> _selectStatus() async {
    filterStatus = await showMenu(
      items: <PopupMenuEntry>[
        PopupMenuItem(
          value: 'all',
          child: Row(
            children: <Widget>[
              Icon(
                Icons.list,
                color: Colors.blue,
              ),
              Text(" Todos"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'active',
          child: Row(
            children: <Widget>[
              Icon(
                Icons.work_outlined,
                color: Colors.blue,
              ),
              Text(" Ativos"),
            ],
          ),
        ),
        PopupMenuItem(
          value: 'inactive',
          child: Row(
            children: <Widget>[
              Icon(
                Icons.work_off_outlined,
                color: Colors.blue,
              ),
              Text(" Inativos"),
            ],
          ),
        ),
      ],
      context: context,
      position: RelativeRect.fromLTRB(100, 100, 0, 0),
    );

    if (filterStatus == 'active') {
      _filterController.text = 'Ativos';
    } else if (filterStatus == 'inactive') {
      _filterController.text = 'Inativos';
    } else {
      _filterController.text = 'Todos';
    }
    _filter(filterStatus);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(2),
          child: Row(
            children: [
              InkWell(
                onTap: () async {
                  final filter = await showMenu(
                    items: <PopupMenuEntry>[
                      PopupMenuItem(
                        value: 'name',
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person,
                              color: Colors.blue,
                            ),
                            Text(" Nome"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'cpfCnpj',
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.credit_card,
                              color: Colors.blue,
                            ),
                            Text(" CPF / CNPJ"),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'status',
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.work_off_outlined,
                              color: Colors.blue,
                            ),
                            Text(" Status"),
                          ],
                        ),
                      ),
                    ],
                    context: context,
                    position: RelativeRect.fromLTRB(0, 100, 0, 0),
                  );
                  if (filter == 'name') {
                    setState(() {
                      icon = Icons.person;
                    });
                  }
                  if (filter == 'cpfCnpj') {
                    setState(() {
                      icon = Icons.credit_card;
                    });
                  }
                  if (filter == 'status') {
                    setState(() {
                      icon = Icons.work_off_outlined;
                    });
                  }
                  _filterController.text = '';
                  Provider.of<CustomerController>(context, listen: false)
                      .filterOption = filter;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Icon(icon, color: Colors.blue),
                ),
              ),
              Expanded(
                child: TextField(
                  onChanged: (v) => _filter(v),
                  onTap: Provider.of<CustomerController>(context, listen: false)
                              .filterOption ==
                          'status'
                      ? () => _selectStatus()
                      : null,
                  readOnly:
                      Provider.of<CustomerController>(context, listen: false)
                                  .filterOption ==
                              'status'
                          ? true
                          : false,
                  controller: _filterController,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: widget.label,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
