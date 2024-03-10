import 'package:flutter/material.dart';
import 'package:foodbuddy/screens/home.dart';
import 'package:foodbuddy/widgets/custom_Text_Form_fild.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});
    static List previousSearchs = [];

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Busqueda'),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              Container(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Row(
                    children: [
                      Expanded(
                        child: CostomTextFormFild(
                          hint: "Buscar",
                          prefixIcon: Icons.search_rounded,
                          controller: searchController,
                          filled: false,
                          suffixIcon:
                              searchController == null ? null : Icons.cancel,
                          onTapSuffixIcon: () {
                            searchController.clear();
                          },
                          onChanged: (pure) {
                            setState(() {});
                          },
                          onEditingComplete: () {
                            SearchPage.previousSearchs.add(searchController.text);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          },
                        ),
                      ),
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          Icons.tune,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                color: Colors.white,
                child: ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: SearchPage.previousSearchs.length,
                    itemBuilder: (context, index) => previousSearchsItem(index)),
              ),
              const SizedBox(
                height: 8,
              ),
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Busquedas Recomendadas",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText2!
                          .copyWith(color: Colors.black, fontWeight: FontWeight.w600 ),
                    ),
                    const SizedBox(
                      height: 24,
                    ),
                    Row(
                      children: [
                        searchSuggestionsTiem("Sushi"),
                        searchSuggestionsTiem("Hamburguesas"),
                        searchSuggestionsTiem("Pasta"),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  previousSearchsItem(int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: InkWell(
        onTap: () {},
        child: Dismissible(
          key: GlobalKey(),
          onDismissed: (DismissDirection dir){
            setState((){});
            SearchPage.previousSearchs.removeAt(index);
          },
          child: Row(
            children: [
              const Icon(
                Icons.restore,
                color: Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                SearchPage.previousSearchs[index],
                style: Theme.of(context)
                    .textTheme
                    .bodyText2!
                    .copyWith(color: Colors.black),
              ),
              const Spacer(),
              const Icon(
                Icons.call_made_outlined,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }

  searchSuggestionsTiem(String text) {
    return Container(
      margin: const EdgeInsets.only(left: 8),
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(30)),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .bodyText2!
            .copyWith(color: Colors.green),
      ),
    );
  }
}
