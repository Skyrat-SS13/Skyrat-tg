import { useBackend } from '../backend';
import { Window } from '../layouts';
import { BlockQuote, Button, Collapsible, Flex, Section, Box } from '../components';

export const NifsoftCatalog = (props, context) => {
  const { act, data } = useBackend(context);
  const { product_list = [], current_user } = data;

  return (
    <Window width={500} height={700}>
      <Window.Content>
        <Flex direction="column">
          {/* {product_list[1].nifsofts.length}a */}
          {product_list.map((product_category) => (
            <Flex.Item key={product_category.key}>
              <ProductCategory product_category={product_category} />
            </Flex.Item>
          ))}
        </Flex>
      </Window.Content>
    </Window>
  );
};

const ProductCategory = (props, context) => {
  const { act, data } = useBackend(context);
  const { product_category } = props;

  return (
    <Section title={product_category.name}>
      <Flex direction="Column">
        {product_category.products.map((product) => (
          <Flex.Item key={product.key}>
            <Box textAlign="center" fontSize="15px">
              <b>{product.name}</b>
            </Box>
            <Collapsible
              title="Product Notes"
              buttons={
                <Button
                  icon="shopping-bag"
                  color="green"
                  onClick={() =>
                    act('purchase_product', {
                      product_to_buy: product.reference,
                      product_price: product.price,
                    })
                  }
                />
              }>
              <BlockQuote>{product.desc}</BlockQuote>
            </Collapsible>
          </Flex.Item>
        ))}
      </Flex>
    </Section>
  );
};
