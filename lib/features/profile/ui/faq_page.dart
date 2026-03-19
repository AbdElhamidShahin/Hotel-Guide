import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:hotel_guide/core/router/routers.dart';
import 'package:hotel_guide/features/profile/ui/widget/faq_item_tile.dart';
import '../../../core/helpers/widget/custom_appbar_widget.dart';
import '../../../core/theme/colors.dart';
import '../logic/faq_cubit/faq_cubit.dart';
import '../logic/faq_cubit/faq_states.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FaqCubit(),
      child: const Directionality(
        textDirection: TextDirection.rtl,
        child: _FaqView(),
      ),
    );
  }
}

class _FaqView extends StatelessWidget {
  const _FaqView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: CustomAppbarWidget(
        name: "الأسئلة الشائعة",

        onTap: () {
          context.pop();
        },
      ),
      body: BlocBuilder<FaqCubit, FaqState>(
        builder: (context, state) {
          return switch (state) {
            FaqLoading() => const Center(child: CircularProgressIndicator()),
            FaqError(:final message) => Center(child: Text(message)),
            FaqLoaded(:final faqs) => ListView.separated(
              padding: const EdgeInsets.all(16),
              itemCount: faqs.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, i) => FaqItemTile(
                faq: faqs[i],
                onTap: () => context.read<FaqCubit>().toggle(faqs[i].id),
              ),
            ),
          };
        },
      ),
    );
  }
}
