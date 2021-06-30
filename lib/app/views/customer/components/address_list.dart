import 'package:api_dotnet_app/app/controllers/customer_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddressList extends StatelessWidget {
  final Function edit;
  final Function delete;

  const AddressList({
    Key? key,
    required this.edit,
    required this.delete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: buildListView(context),
      ),
    );
  }

  ListView buildListView(BuildContext context) {
    CustomerController controller =
        Provider.of<CustomerController>(context, listen: true);
    return ListView.builder(
      itemCount: controller.customerEditing.addresses.length,
      itemBuilder: (context, index) {
        return Card(
          elevation: 2.5,
          child: ListTile(
            onTap: () => edit(controller.customerEditing.addresses[index]),
            title: Text(
              '${controller.customerEditing.addresses[index].address}, ' +
                  '${controller.customerEditing.addresses[index].number} - ' +
                  '${controller.customerEditing.addresses[index].district}',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            subtitle: Text(
              '${controller.customerEditing.addresses[index].city}, ' +
                  '${controller.customerEditing.addresses[index].state}',
              style: TextStyle(
                fontSize: 17,
              ),
            ),
            trailing: IconButton(
              icon: Icon(Icons.delete),
              onPressed: () =>
                  delete(controller.customerEditing.addresses[index].id),
            ),
          ),
        );
      },
    );
  }
}
