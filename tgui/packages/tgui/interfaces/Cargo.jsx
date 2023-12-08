import { flow } from 'common/fp';
import { filter, sortBy } from 'common/collections';
import { useBackend, useSharedState } from '../backend';
import { AnimatedNumber, Box, Button, Flex, Icon, Input, RestrictedInput, LabeledList, NoticeBox, Section, Stack, Table, Tabs } from '../components';
import { formatMoney } from '../format';
import { Window } from '../layouts';

export const Cargo = (props) => {
  return (
    <Window width={800} height={750}>
      <Window.Content scrollable>
        <CargoContent />
      </Window.Content>
    </Window>
  );
};

export const CargoContent = (props) => {
  /* SKYRAT EDIT BELOW - ADDS act */
  const { act, data } = useBackend();
  /* SKYRAT EDIT END */
  const [tab, setTab] = useSharedState('tab', 'catalog');
  const { cart = [], requests = [], requestonly } = data;
  const cart_length = cart.reduce((total, entry) => total + entry.amount, 0);
  return (
    <Box>
      <CargoStatus />
      <Section fitted>
        <Tabs>
          <Tabs.Tab
            icon="list"
            selected={tab === 'catalog'}
            onClick={() => setTab('catalog')}>
            Catalog
          </Tabs.Tab>
          <Tabs.Tab
            icon="envelope"
            textColor={tab !== 'requests' && requests.length > 0 && 'yellow'}
            selected={tab === 'requests'}
            onClick={() => setTab('requests')}>
            Requests ({requests.length})
          </Tabs.Tab>
          <Tabs.Tab
            icon="clipboard-list"
            selected={tab === 'company_import_window'}
            onClick={() => act('company_import_window')}>
            Company Imports
          </Tabs.Tab>
          {!requestonly && (
            <>
              <Tabs.Tab
                icon="shopping-cart"
                textColor={tab !== 'cart' && cart_length > 0 && 'yellow'}
                selected={tab === 'cart'}
                onClick={() => setTab('cart')}>
                Checkout ({cart_length})
              </Tabs.Tab>
              <Tabs.Tab
                icon="question"
                selected={tab === 'help'}
                onClick={() => setTab('help')}>
                Help
              </Tabs.Tab>
            </>
          )}
        </Tabs>
      </Section>
      {tab === 'catalog' && <CargoCatalog />}
      {tab === 'requests' && <CargoRequests />}
      {tab === 'cart' && <CargoCart />}
      {tab === 'help' && <CargoHelp />}
      {tab === 'company_import_window' && tab === 'catalog'}
    </Box>
  );
};

const CargoStatus = (props) => {
  const { act, data } = useBackend();
  const {
    department,
    grocery,
    away,
    docked,
    loan,
    loan_dispatched,
    location,
    message,
    points,
    requestonly,
    can_send,
  } = data;
  return (
    <Section
      title={department}
      buttons={
        <Box inline bold>
          <AnimatedNumber
            value={points}
            format={(value) => formatMoney(value)}
          />
          {' credits'}
        </Box>
      }>
      <LabeledList>
        <LabeledList.Item label="Shuttle">
          {(docked && !requestonly && can_send && (
            <Button
              color={(grocery && 'orange') || 'green'}
              content={location}
              tooltip={
                (grocery &&
                  'The kitchen is waiting for their grocery supply delivery!') ||
                ''
              }
              tooltipPosition="right"
              onClick={() => act('send')}
            />
          )) ||
            location}
        </LabeledList.Item>
        <LabeledList.Item label="CentCom Message">{message}</LabeledList.Item>
        {!!loan && !requestonly && (
          <LabeledList.Item label="Loan">
            {(!loan_dispatched && (
              <Button
                content="Loan Shuttle"
                disabled={!(away && docked)}
                onClick={() => act('loan')}
              />
            )) || <Box color="bad">Loaned to Centcom</Box>}
          </LabeledList.Item>
        )}
      </LabeledList>
    </Section>
  );
};

/**
 * Take entire supplies tree
 * and return a flat supply pack list that matches search,
 * sorted by name and only the first page.
 * @param {any[]} supplies Supplies list.
 * @param {string} search The search term
 * @returns {any[]} The flat list of supply packs.
 */
const searchForSupplies = (supplies, search) => {
  search = search.toLowerCase();

  return flow([
    (categories) => categories.flatMap((category) => category.packs),
    filter(
      (pack) =>
        pack.name?.toLowerCase().includes(search.toLowerCase()) ||
        pack.desc?.toLowerCase().includes(search.toLowerCase())
    ),
    sortBy((pack) => pack.name),
    (packs) => packs.slice(0, 25),
  ])(supplies);
};

export const CargoCatalog = (props) => {
  const { express } = props;
  const { act, data } = useBackend();

  const { self_paid, app_cost } = data;

  const supplies = Object.values(data.supplies);
  const { amount_by_name = [], max_order } = data;

  const [activeSupplyName, setActiveSupplyName] = useSharedState(
    'supply',
    supplies[0]?.name
  );

  const [searchText, setSearchText] = useSharedState('search_text', '');

  const activeSupply =
    activeSupplyName === 'search_results'
      ? { packs: searchForSupplies(supplies, searchText) }
      : supplies.find((supply) => supply.name === activeSupplyName);

  return (
    <Section
      title="Catalog"
      buttons={
        !express && (
          <>
            <CargoCartButtons />
            <Button.Checkbox
              ml={2}
              content="Buy Privately"
              checked={self_paid}
              onClick={() => act('toggleprivate')}
            />
          </>
        )
      }>
      <Flex>
        <Flex.Item ml={-1} mr={1}>
          <Tabs vertical>
            <Tabs.Tab
              key="search_results"
              selected={activeSupplyName === 'search_results'}>
              <Stack align="baseline">
                <Stack.Item>
                  <Icon name="search" />
                </Stack.Item>
                <Stack.Item grow>
                  <Input
                    fluid
                    placeholder="Search..."
                    value={searchText}
                    onInput={(e, value) => {
                      if (value === searchText) {
                        return;
                      }

                      if (value.length) {
                        // Start showing results
                        setActiveSupplyName('search_results');
                      } else if (activeSupplyName === 'search_results') {
                        // return to normal category
                        setActiveSupplyName(supplies[0]?.name);
                      }
                      setSearchText(value);
                    }}
                    onChange={(e, value) => {
                      // Allow edge cases like the X button to work
                      const onInput = e.target?.props?.onInput;
                      if (onInput) {
                        onInput(e, value);
                      }
                    }}
                  />
                </Stack.Item>
              </Stack>
            </Tabs.Tab>
            {supplies.map((supply) => (
              <Tabs.Tab
                key={supply.name}
                selected={supply.name === activeSupplyName}
                onClick={() => {
                  setActiveSupplyName(supply.name);
                  setSearchText('');
                }}>
                {supply.name} ({supply.packs.length})
              </Tabs.Tab>
            ))}
          </Tabs>
        </Flex.Item>
        <Flex.Item grow={1} basis={0}>
          <Table>
            {activeSupply?.packs.map((pack) => {
              const tags = [];
              if (pack.small_item) {
                tags.push('Small');
              }
              if (pack.access) {
                tags.push('Restricted');
              }
              return (
                <Table.Row key={pack.name} className="candystripe">
                  <Table.Cell>{pack.name}</Table.Cell>
                  <Table.Cell collapsing color="label" textAlign="right">
                    {tags.join(', ')}
                  </Table.Cell>
                  <Table.Cell collapsing textAlign="right">
                    <Button
                      fluid
                      tooltip={pack.desc}
                      tooltipPosition="left"
                      disabled={(amount_by_name[pack.name] || 0) >= max_order}
                      onClick={() =>
                        act('add', {
                          id: pack.id,
                        })
                      }>
                      {formatMoney(
                        (self_paid && !pack.goody) || app_cost
                          ? Math.round(pack.cost * 1.1)
                          : pack.cost
                      )}
                      {' cr'}
                    </Button>
                  </Table.Cell>
                </Table.Row>
              );
            })}
          </Table>
        </Flex.Item>
      </Flex>
    </Section>
  );
};

const CargoRequests = (props) => {
  const { act, data } = useBackend();
  const { requestonly, can_send, can_approve_requests } = data;
  const requests = data.requests || [];
  // Labeled list reimplementation to squeeze extra columns out of it
  return (
    <Section
      title="Active Requests"
      buttons={
        !requestonly && (
          <Button
            icon="times"
            content="Clear"
            color="transparent"
            onClick={() => act('denyall')}
          />
        )
      }>
      {requests.length === 0 && <Box color="good">No Requests</Box>}
      {requests.length > 0 && (
        <Table>
          {requests.map((request) => (
            <Table.Row key={request.id} className="candystripe">
              <Table.Cell collapsing color="label">
                #{request.id}
              </Table.Cell>
              <Table.Cell>{request.object}</Table.Cell>
              <Table.Cell>
                <b>{request.orderer}</b>
              </Table.Cell>
              <Table.Cell width="25%">
                <i>{request.reason}</i>
              </Table.Cell>
              <Table.Cell collapsing textAlign="right">
                {formatMoney(request.cost)} cr
              </Table.Cell>
              {(!requestonly || can_send) && can_approve_requests && (
                <Table.Cell collapsing>
                  <Button
                    icon="check"
                    color="good"
                    onClick={() =>
                      act('approve', {
                        id: request.id,
                      })
                    }
                  />
                  <Button
                    icon="times"
                    color="bad"
                    onClick={() =>
                      act('deny', {
                        id: request.id,
                      })
                    }
                  />
                </Table.Cell>
              )}
            </Table.Row>
          ))}
        </Table>
      )}
    </Section>
  );
};

const CargoCartButtons = (props) => {
  const { act, data } = useBackend();
  const { requestonly, can_send, can_approve_requests } = data;
  const cart = data.cart || [];
  const total = cart.reduce((total, entry) => total + entry.cost, 0);
  return (
    <>
      <Box inline mx={1}>
        {cart.length === 0 && 'Cart is empty'}
        {cart.length === 1 && '1 item'}
        {cart.length >= 2 && cart.length + ' items'}{' '}
        {total > 0 && `(${formatMoney(total)} cr)`}
      </Box>
      {!requestonly && !!can_send && !!can_approve_requests && (
        <Button
          icon="times"
          color="transparent"
          content="Clear"
          onClick={() => act('clear')}
        />
      )}
    </>
  );
};

const CartHeader = (props) => {
  const { data } = useBackend();
  return (
    <Section>
      <Stack>
        <Stack.Item mt="4px">Current-Cart</Stack.Item>
        <Stack.Item ml="200px" mt="3px">
          Quantity
        </Stack.Item>
        <Stack.Item ml="72px">
          <CargoCartButtons />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const CargoCart = (props) => {
  const { act, data } = useBackend();
  const {
    requestonly,
    away,
    docked,
    location,
    can_send,
    amount_by_name,
    max_order,
  } = data;
  const cart = data.cart || [];
  return (
    <Section fill>
      <CartHeader />
      {cart.length === 0 && <Box color="label">Nothing in cart</Box>}
      {cart.length > 0 && (
        <Table>
          {cart.map((entry) => (
            <Table.Row key={entry.id} className="candystripe">
              <Table.Cell collapsing color="label" inline width="210px">
                #{entry.id}&nbsp;{entry.object}
              </Table.Cell>
              <Table.Cell inline ml="65px" width="40px">
                {(can_send && entry.can_be_cancelled && (
                  <RestrictedInput
                    width="40px"
                    minValue={0}
                    maxValue={max_order}
                    value={entry.amount}
                    onEnter={(e, value) =>
                      act('modify', {
                        order_name: entry.object,
                        amount: value,
                      })
                    }
                  />
                )) || <Input width="40px" value={entry.amount} disabled />}
              </Table.Cell>
              <Table.Cell inline ml="5px" width="10px">
                {!!can_send && !!entry.can_be_cancelled && (
                  <Button
                    icon="plus"
                    disabled={amount_by_name[entry.object] >= max_order}
                    onClick={() =>
                      act('add_by_name', { order_name: entry.object })
                    }
                  />
                )}
              </Table.Cell>
              <Table.Cell inline ml="15px" width="10px">
                {!!can_send && !!entry.can_be_cancelled && (
                  <Button
                    icon="minus"
                    onClick={() => act('remove', { order_name: entry.object })}
                  />
                )}
              </Table.Cell>
              <Table.Cell collapsing textAlign="right" inline ml="50px">
                {entry.paid > 0 && <b>[Paid Privately x {entry.paid}]</b>}
                {formatMoney(entry.cost)} {entry.cost_type}
                {entry.dep_order > 0 && <b>[Department x {entry.dep_order}]</b>}
              </Table.Cell>
              <Table.Cell inline mt="20px" />
            </Table.Row>
          ))}
        </Table>
      )}
      {cart.length > 0 && !requestonly && (
        <Box mt={2}>
          {(away === 1 && docked === 1 && (
            <Button
              color="green"
              style={{
                lineHeight: '28px',
                padding: '0 12px',
              }}
              content="Confirm the order"
              onClick={() => act('send')}
            />
          )) || <Box opacity={0.5}>Shuttle in {location}.</Box>}
        </Box>
      )}
    </Section>
  );
};

const CargoHelp = (props) => {
  return (
    <>
      <Section title="Department Orders">
        Each department on the station will order crates from their own personal
        consoles. These orders are ENTIRELY FREE! They do not come out of
        cargo&apos;s budget, and rather put the consoles on cooldown. So
        here&apos;s where you come in: The ordered crates will show up on your
        supply console, and you need to deliver the crates to the orderers.
        You&apos;ll actually be paid the full value of the department crate on
        delivery if the crate was not tampered with, making the system a good
        source of income.
        <br />
        <b>
          Examine a department order crate to get specific details about where
          the crate needs to go.
        </b>
      </Section>
      <Section title="MULEbots">
        MULEbots are slow but loyal delivery bots that will get crates delivered
        with minimal technician effort required. It is slow, though, and can be
        tampered with while en route.
        <br />
        <b>Setting up a MULEbot is easy:</b>
        <br />
        <b>1.</b> Drag the crate you want to deliver next to the MULEbot.
        <br />
        <b>2.</b> Drag the crate on top of MULEbot. It should load on.
        <br />
        <b>3.</b> Open your PDA.
        <br />
        <b>4.</b> Click <i>Delivery Bot Control</i>.<br />
        <b>5.</b> Click <i>Scan for Active Bots</i>.<br />
        <b>6.</b> Choose your MULE.
        <br />
        <b>7.</b> Click on <i>Destination: (set)</i>.<br />
        <b>8.</b> Choose a destination and click OK.
        <br />
        <b>9.</b> Click <i>Proceed</i>.
      </Section>
      <Section title="Disposals Delivery System">
        In addition to MULEs and hand-deliveries, you can also make use of the
        disposals mailing system. Note that a break in the disposal piping could
        cause your package to be lost (this hardly ever happens), so this is not
        always the most secure ways to deliver something. You can wrap up a
        piece of paper and mail it the same way if you (or someone at the desk)
        wants to mail a letter.
        <br />
        <b>Using the Disposals Delivery System is even easier:</b>
        <br />
        <b>1.</b> Wrap your item/crate in packaging paper.
        <br />
        <b>2.</b> Use the destinations tagger to choose where to send it.
        <br />
        <b>3.</b> Tag the package.
        <br />
        <b>4.</b> Stick it on the conveyor and let the system handle it.
        <br />
      </Section>
      <NoticeBox textAlign="center" info mb={0}>
        Pondering something not included here? When in doubt, ask the QM!
      </NoticeBox>
    </>
  );
};
