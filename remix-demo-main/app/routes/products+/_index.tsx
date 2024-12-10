import React from 'react';
import { Stack, useMediaQuery } from '@mui/material';
import { useTranslation } from 'react-i18next';
import { useSnackbar } from 'notistack';

import { useQueryProductsList, useMutationProductsDelete } from '~/services/products';
import { SkeletonOnLoading } from '~/global/components/skeleton-on-loading';
import { AppButton } from '~/global/components/app-button';
import { ProductsTable } from './components/table';
import { ProductsCardList } from './components/product-card-list';

//
//

export default function Products() {
  const { t } = useTranslation(['common']);
  const { data, isLoading } = useQueryProductsList();
  const { enqueueSnackbar } = useSnackbar();
  const deleteItem = useMutationProductsDelete();

  const isMobile = useMediaQuery('(max-width:600px)');

  const doDeleteItem = (item) => {
    if (!window.confirm(t('common:deleteConfirm', { item: item.title.en || item.title.ar }))) return;

    deleteItem.mutate(
      { id: item.productId },
      {
        onSuccess: (result) => {
          result?.meta?.message && enqueueSnackbar(result.meta.message, { variant: 'success' });
        },
        onError: (err) => {
          enqueueSnackbar(err?.message || 'Unknown error', { variant: 'error' });
        },
      }
    );
  };

  return (
    <>
      <Stack alignItems="flex-end" my={2}>
        <SkeletonOnLoading isLoading={isLoading}>
          <AppButton to="/products/create" variant="contained">
            {t('common:create')}
          </AppButton>
        </SkeletonOnLoading>
      </Stack>

      {isMobile ? (
        <ProductsCardList data={data?.result} isLoading={isLoading} doDeleteItem={doDeleteItem} />
      ) : (
        <ProductsTable data={data?.result} isLoading={isLoading} />
      )}
    </>
  );
}
