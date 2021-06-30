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
    CustomerService(context).remove(customer.id);
  }

  ListView _customerList() {
    CustomerController controller =
        Provider.of<CustomerController>(context, listen: true);

    return ListView.builder(
      itemCount: controller.count,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(controller.customers[index].name),
          subtitle: Text(
              'Endereços: ${controller.customers[index].addresses.length}'),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                onPressed: () => _edit(controller.customers[index]),
                icon: Icon(Icons.edit),
              ),
              IconButton(
                onPressed: () => _remove(controller.customers[index]),
                icon: Icon(Icons.delete),
              ),
            ],
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
          IconButton(
            onPressed: _add,
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: _customerList(),
    );
  }
}
