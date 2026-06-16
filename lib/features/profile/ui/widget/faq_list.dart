import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/faq_model.dart';
import '../../logic/faq_cubit/faq_cubit.dart';
import 'faq_item_tile.dart';

/// ✅ Fix: was an empty file — implemented as a reusable FAQ list widget.
class FaqList extends StatelessWidget {
  final List<FaqModel> faqs;
  const FaqList({super.key, required this.faqs});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: faqs.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, i) => FaqItemTile(
        faq: faqs[i],
        onTap: () => context.read<FaqCubit>().toggle(faqs[i].id),
      ),
    );
  }
}
