import React from 'react';
import { Box, Button, Card, CardActions, CardContent, CardMedia, Stack, Typography } from '@mui/material';
import { DeleteOutline } from '@mui/icons-material';

import { AppButton } from '~/global/components/app-button';
import { ApiProduct } from '~/api-client/types';
import defaultImage from 'public/assets/empty.png'
//
//

type ProductCardProps = {
  product: ApiProduct;
  doDeleteItem: (item: ApiProduct) => void;
};

export const ProductCard: React.FC<ProductCardProps> = ({ product, doDeleteItem }) => {
  return (

    <Card sx={{ display: 'flex', flexDirection: 'column', margin: 1, maxWidth: 600 }}>
      <div style={{ display: 'flex', flexDirection: 'row', margin: 1, maxWidth: 600 }}>
        <CardMedia
          component="img"
          sx={{ width: 120, height: 120, objectFit: 'cover', borderRadius: 1 }}
          image={product.image || defaultImage}
          alt={product.title.en || product.title.ar}
        />

        <CardContent sx={{ flex: 1, display: 'flex', flexDirection: 'column', justifyContent: 'space-between', padding: 2 }}>
          <Box>
            <Typography variant="h6" fontWeight="bold">
              {product.title.en || product.title.ar}
            </Typography>

            <Typography variant="body1" color="text.primary">
              ${product.price.toLocaleString()}
            </Typography>

            {product.priceSale && (
              <Typography variant="body2" color="text.secondary" >
                (Sale: ${product.priceSale.toLocaleString()})
              </Typography>
            )}

            {product.isActive ? (
              <Typography variant="caption" color="success.main">
                Active
              </Typography>
            ) : (
              <Typography variant="caption" color="error.main">
                Inactive
              </Typography>
            )}
          </Box>
        </CardContent>
        <Box sx={{ flex: 1, display: 'flex', flexDirection: 'column', justifyContent: 'space-between', padding: 2, float: 'right' }}>
          <Typography variant="caption" color="text.secondary">
            Created: {new Date(product.createdAt).toLocaleDateString()}
          </Typography>
          {product.updatedAt && product.updatedAt !== product.createdAt && (
            <Typography variant="caption" color="text.secondary">
              Updated: {new Date(product.updatedAt).toLocaleDateString()}
            </Typography>
          )}
        </Box>
      </div>

      <CardActions
        sx={{
          flexDirection: 'row',
          alignItems: 'flex-start',
          justifyContent: 'space-between',
          padding: 1,
        }}
      >
        <AppButton to={`/products/${product.productId}`} variant="contained" size="small" fullWidth>
          Edit
        </AppButton>
        <Button
          variant="outlined"
          color="error"
          size="small"
          fullWidth
          startIcon={<DeleteOutline />}
          onClick={() => doDeleteItem(product)}
        >
          Delete
        </Button>
      </CardActions>
    </Card>
  );
};
