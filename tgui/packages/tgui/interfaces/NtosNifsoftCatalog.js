import { useBackend, useSharedState } from '../backend';
import { NtosWindow } from '../layouts';
import { BlockQuote, Button, Collapsible, Flex, Section, Tabs, LabeledList, Box, Icon } from '../components';

export const NtosNifsoftCatalog = (props, context) => {
  const { act, data } = useBackend(context);
  const { product_list = [], rewards_points, current_balance } = data;
  const [tab, setTab] = useSharedState(
    context,
    'product_category',
    product_list[0].name
  );

  const products =
    product_list.find((product_category) => product_category.name === tab)
      ?.products || [];

  return (
    <NtosWindow width={500} height={700}>
      <NtosWindow.Content scrollable>
        <Section>
          <LabeledList>
            <LabeledList.Item label={'Credits in account'}>
              {current_balance}
            </LabeledList.Item>
            <LabeledList.Item label="Rewards Points">
              <b>{rewards_points}</b>
            </LabeledList.Item>
          </LabeledList>
        </Section>
        <Tabs fluid>
          {product_list.map((product_category) => (
            <Tabs.Tab
              key={product_category.key}
              textAlign="center"
              onClick={() => setTab(product_category.name)}
              selected={tab === product_category.name}>
              <b>{product_category.name}</b>
            </Tabs.Tab>
          ))}
        </Tabs>
        <ProductCategory products={products} />
      </NtosWindow.Content>
    </NtosWindow>
  );
};

const ProductCategory = (props, context) => {
  const { act, data } = useBackend(context);
  const { target_nif, paying_account, rewards_points, current_balance } = data;
  const { products } = props;

  return (
    <Section>
      <Flex direction="Column">
        {products.map((product) => (
          <Flex.Item key={product.key}>
            <Section
              title={
                <span>
                  {<Icon name={product.ui_icon} />}
                  {' ' + product.name}
                </span>
              }
              fill={false}>
              <Collapsible title="Product Notes">
                <BlockQuote>{product.desc}</BlockQuote>
              </Collapsible>
              <Button
                icon="shopping-bag"
                color="green"
                disabled={!paying_account || current_balance < product.price}
                onClick={() =>
                  act('purchase_product', {
                    product_to_buy: product.reference,
                    product_cost: product.price,
                    rewards_purchase: false,
                  })
                }
                fluid>
                Purchase for {product.price}cr
              </Button>
              <Button
                icon="piggy-bank"
                color="green"
                disabled={
                  !product.points_purchasable || rewards_points < product.price
                }
                onClick={() =>
                  act('purchase_product', {
                    product_to_buy: product.reference,
                    product_cost: product.price,
                    rewards_purchase: true,
                  })
                }
                fluid>
                Purchase for {product.price} rewards points
              </Button>
              <Box opacity={0.85} textAlign="center">
                Purchasing this item will give you:{' '}
                {product.rewards_points_rate * product.price} rewards points
              </Box>
            </Section>
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};
