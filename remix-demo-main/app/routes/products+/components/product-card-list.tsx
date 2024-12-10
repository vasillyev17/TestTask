import React from 'react';
import { Box, CircularProgress, Grid, Typography } from '@mui/material';

import { ProductCard } from './product-card';
import { ApiProduct } from '~/api-client/types';

//
//

type ProductsCardListProps = {
  data?: ApiProduct[];
  isLoading: boolean;
  doDeleteItem: (item: ApiProduct) => void;
};

export const ProductsCardList: React.FC<ProductsCardListProps> = ({ data, isLoading, doDeleteItem }) => {
  if (isLoading) {
    return (
      <Box display="flex" justifyContent="center" alignItems="center" height="200px">
        <CircularProgress />
      </Box>
    );
  }

  if (!data || data.length === 0) {
    return (
      <Box textAlign="center" my={4}>
        <Typography variant="h6" color="text.secondary">
          No Products Found
        </Typography>
      </Box>
    );
  }

  return (
    <Grid container spacing={2}>
      {data.map((product) => (
        <Grid item xs={12} sm={6} md={4} key={product.productId}>
          <ProductCard product={product} doDeleteItem={doDeleteItem} />
        </Grid>
      ))}
    </Grid>
  );
};
