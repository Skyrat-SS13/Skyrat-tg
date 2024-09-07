import { useBackend, useSharedState } from '../../backend';
import { Stack, Tabs } from '../../components';
import { Window } from '../../layouts';
import { CargoCart } from './CargoCart';
import { CargoCatalog } from './CargoCatalog';
import { CargoHelp } from './CargoHelp';
import { CargoRequests } from './CargoRequests';
import { CargoStatus } from './CargoStatus';
import { CargoData } from './types';

enum TAB {
  Catalog = 'catalog',
  Requests = 'requests',
<<<<<<< HEAD
  /* SKYRAT EDIT BELOW - ADDS company imports */
  Imports = 'company_import_window',
  /* SKYRAT EDIT END */
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
  Cart = 'cart',
  Help = 'help',
}

export function Cargo(props) {
  return (
    <Window width={800} height={750}>
      <Window.Content>
        <CargoContent />
      </Window.Content>
    </Window>
  );
}

export function CargoContent(props) {
<<<<<<< HEAD
  /* SKYRAT EDIT BELOW - ADDS act */
  const { act, data } = useBackend<CargoData>();
  /* SKYRAT EDIT END */
=======
  const { data } = useBackend<CargoData>();
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3

  const { cart = [], requests = [], requestonly } = data;

  const [tab, setTab] = useSharedState('cargotab', TAB.Catalog);

  let amount = 0;
  for (let i = 0; i < cart.length; i++) {
    amount += cart[i].amount;
  }

  return (
    <Stack fill vertical>
      <Stack.Item>
        <CargoStatus />
      </Stack.Item>
      <Stack.Item>
        <Tabs fluid>
          <Tabs.Tab
            icon="list"
            selected={tab === TAB.Catalog}
            onClick={() => setTab(TAB.Catalog)}
          >
            Catalog
          </Tabs.Tab>
<<<<<<< HEAD
          {/* SKYRAT EDIT START - Company imports */}
          <Tabs.Tab
            icon="clipboard-list"
            selected={tab === TAB.Imports}
            onClick={() => act(TAB.Imports)}
          >
            Company Imports
          </Tabs.Tab>
          {/* SKYRAT EDIT END */}
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
          <Tabs.Tab
            icon="envelope"
            textColor={tab !== TAB.Requests && requests.length > 0 && 'yellow'}
            selected={tab === TAB.Requests}
            onClick={() => setTab(TAB.Requests)}
          >
            Requests ({requests.length})
          </Tabs.Tab>
          {!requestonly && (
            <>
              <Tabs.Tab
                icon="shopping-cart"
                textColor={tab !== TAB.Cart && amount > 0 && 'yellow'}
                selected={tab === TAB.Cart}
                onClick={() => setTab(TAB.Cart)}
              >
                Checkout ({amount})
              </Tabs.Tab>
              <Tabs.Tab
                icon="question"
                selected={tab === TAB.Help}
                onClick={() => setTab(TAB.Help)}
              >
                Help
              </Tabs.Tab>
            </>
          )}
        </Tabs>
      </Stack.Item>
      <Stack.Item grow mt={0}>
        {tab === TAB.Catalog && <CargoCatalog />}
        {tab === TAB.Requests && <CargoRequests />}
        {tab === TAB.Cart && <CargoCart />}
        {tab === TAB.Help && <CargoHelp />}
      </Stack.Item>
    </Stack>
  );
}
