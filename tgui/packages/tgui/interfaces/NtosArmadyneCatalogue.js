import { useBackend } from '../backend';
import { Button, Section, Collapsible, LabeledList } from '../components';
import { NtosWindow } from '../layouts';

export const NtosArmadyneCatalogue = (props, context) => {
  const { act, data } = useBackend(context);
  const { points, orders, money, money_max, card_inserted } = data;

  return (
    <NtosWindow>
      <NtosWindow.Content>
        <Section>
          <h2>Armadyne Order Catalogue</h2>
          <i>
            The contents of this app should only be accessed by a representative
            of the Armadyne corporation.
            <br />
            <br />
            Use of purchaser&apos;s funds recommended to assist in point
            collection for order.
          </i>
        </Section>
        <Section>
          <h4 style={{ 'float': 'right' }}>
            {points} pt{points === 1 ? '' : 's'}
          </h4>
          <Button
            style={{ 'float': 'right' }}
            disabled={money >= money_max || !card_inserted}
            onClick={() => act('loadcash')}>
            Load money from card
          </Button>
          <br />
          <br />
          <b>Money:</b> ${money} / ${money_max}
          <br />
          <br />
          <div style={{ 'border': '1px red outset' }} />
          <br />
          {orders.map((order) => {
            <Section title={order.name}>
              {order.desc}
              <div style={{ 'float': 'right' }}>
                <Button
                  disabled={order.cost > points}
                  onClick={() => act('purchase', { orderName: order.name })}>
                  Purchase {order.cost} pt{order.cost === 1 ? '' : 's'}
                </Button>
              </div>
              <br />
              <br />
              <Collapsible title="Contents">
                <LabeledList>
                  {order.string_contents.map((entry) => {
                    <LabeledList.Item>{entry}</LabeledList.Item>;
                  })}
                </LabeledList>
              </Collapsible>
            </Section>;
          })}
        </Section>
      </NtosWindow.Content>
    </NtosWindow>
  );
};
