// THIS IS A SKYRAT UI FILE
import { Fragment } from 'react';

import { useBackend, useLocalState } from '../backend';
import {
  Box,
  Button,
  Collapsible,
  Divider,
  Icon,
  ProgressBar,
  Section,
  Stack,
  Table,
} from '../components';
import { TableRow } from '../components/Table';
import { Window } from '../layouts';

const brassColor = '#DFC69C';
const tinkerCache = '#B5FD9D';
const replicaFab = '#DED09F';
const clockMarauder = '#FF9D9D';

const convertPower = (power_in) => {
  const units = ['W', 'kW', 'MW', 'GW'];
  let power = 0;
  let value = power_in;
  while (value >= 1000 && power < units.length) {
    power++;
    value /= 1000;
  }
  return Math.round((value + Number.EPSILON) * 100) / 100 + units[power];
};

export const ClockworkSlab = (props) => {
  const [selectedTab, setSelectedTab] = useLocalState(
    'selectedTab',
    'Servitude',
  );
  return (
    <Window theme="clockwork" width={860} height={700}>
      <Window.Content>
        <Section
          title={
            <Box inline color={'good'}>
              <Icon name={'cog'} rotation={0} spin={1} />
              {' Clockwork Slab '}
              <Icon name={'cog'} rotation={35} spin={1} />
            </Box>
          }
        >
          <ClockworkButtonSelection />
        </Section>
        <div className="ClockSlab__left">
          <Section height="100%" overflowY="auto">
            <ClockworkSpellList selectedTab={selectedTab} />
          </Section>
        </div>
        <div className="ClockSlab__right">
          <div className="ClockSlab__stats">
            <Section height="100%">
              <ClockworkOverview />
            </Section>
          </div>
          <div className="ClockSlab__current">
            <Section
              height="100%"
              overflowY="auto"
              title="Servants of the Cog vol.1"
            >
              <ClockworkHelp />
            </Section>
          </div>
        </div>
      </Window.Content>
    </Window>
  );
};

const ClockworkHelp = (props) => {
  return (
    <>
      <Collapsible title="Where To Start" color="average" open={1}>
        <Section>
          After a long and destructive war, Rat&#39;Var has been imprisoned
          inside a dimension of suffering.
          <br />
          You are one of his last remaining, most loyal servants. <br />
          You are very weak and have little power, with most of your scriptures
          unable to function.
          <br />
          <b>
            Install&nbsp;
            <font color={brassColor}>Integration Cogs&nbsp;</font>
            to unlock more scriptures and siphon power!
          </b>
          <br />
        </Section>
      </Collapsible>
      <Collapsible title="Unlocking Scriptures" color="average">
        <Section>
          Most scriptures require <b>cogs</b> to unlock.
          <br />
          Invoke&nbsp;
          <font color={brassColor}>
            <b>Integration Cog&nbsp;</b>
          </font>
          to summon an Integration Cog, which can be placed into any&nbsp;
          <b>APC&nbsp;</b>
          on the station.
          <br />
          Slice open the&nbsp;
          <b>APC&nbsp;</b>
          with the&nbsp;
          <b>Integration Cog&nbsp;</b>
          and then insert it in to begin siphoning power. However, you will only
          gain a cog after the Integration Cog has been inside the APC for 5
          minutes.
          <br />
        </Section>
      </Collapsible>
      <Collapsible title="Research" color="average">
        <Section>
          Some scriptures and equipment take more than simply cogs to unlock.
          <br />
          The&nbsp;
          <font color={brassColor}>
            <b>Technologist&apos;s Lectern&nbsp;</b>
          </font>
          can be used to research normally-locked equipment and abilities, but
          not easily.
          <br />
          Each individual piece of research can only be done in a specific
          location, and will take time to finish. In that time, your presence
          will be exceedingly obvious.
          <br />
        </Section>
      </Collapsible>
      <Collapsible title="Defense" color="average">
        <Section>
          <b>
            You have a wide range of structures and powers that will be vital in
            defending your grounds.
          </b>
          <br />
          <b>
            <font color={brassColor}>Structures:&nbsp;</font>
          </b>
          A variety of invaluable structures are available to you, allowing
          effective defense of your sanctum. Use your Slab on a structure to
          gain extra information.
          <br />
          <b>
            <font color={brassColor}>Traps:&nbsp;</font>
          </b>
          Traps are useful contraptions, able to be created at a{' '}
          <font color={tinkerCache}>Tinkerer&apos;s Cache</font>. Use your Slab
          to link traps and triggers together.
          <br />
          <b>
            <font color={clockMarauder}>Clockwork Marauder:&nbsp;</font>
          </b>
          A powerful shell that can deflect attacks and delivers a strong blow
          in close quarter combat.
          <br />
          <br />
        </Section>
      </Collapsible>
      <Collapsible title="Tips" color="average">
        <Section>
          <b>
            <font color={brassColor}>Vitality:&nbsp;</font>
          </b>
          You need vitality to create{' '}
          <font color={clockMarauder}>Clockwork Marauders</font>, which is
          gotten from sacrificing living beings to a{' '}
          <font color={brassColor}>Vitality Sigil</font>.
          <br />
          <b>
            <font color={brassColor}>Power:&nbsp;</font>
          </b>
          Watch your power upkeep! You&apos;re dependent on your cogged APCs to
          stay powered, and a lot of structures can drain it quickly.
          <br />
          <b>
            <font color={brassColor}>Your Base:&nbsp;</font>
          </b>
          Make sure to have a defensible base of operations! You&apos;re
          significantly stronger while on brass tiles, so make your home
          indefensible.
          <br />
          <b>
            <font color={replicaFab}>Replica Fabricator:&nbsp;</font>
          </b>
          The Replica Fabricator is one of the strongest tools available to you,
          via the <font color={tinkerCache}>Tinkerer&apos;s Cache</font>. It
          allows the conversion of all materials into power, which can be used
          to create floors, walls, and airlocks. The airlocks will shock all
          non-cultists.
          <br />
          <b>
            <font color={brassColor}>Nar&apos;sie:&nbsp;</font>
          </b>
          Nar&apos;sian cultists are your greatest foe! Some of your spells are
          less effective on them, and vice-versa. What remains of Ratvar may
          reward a vitality sacrifice of such heresy.
          <br />
          <br />
        </Section>
      </Collapsible>
    </>
  );
};

const ClockworkSpellList = (props) => {
  const { act, data } = useBackend();
  const { selectedTab } = props;
  const { scriptures = [] } = data;
  return (
    <Table>
      {scriptures.map((script) =>
        script.type === selectedTab ? (
          <Fragment key={script}>
            <TableRow>
              <Table.Cell bold>{script.name}</Table.Cell>
              <Table.Cell collapsing textAlign="right">
                <Button
                  fluid
                  color={script.purchased ? 'default' : 'average'}
                  content={
                    script.purchased
                      ? 'Invoke ' + convertPower(script.cost)
                      : script.cog_cost + ' Cogs'
                  }
                  tooltip={
                    script.research_required
                      ? 'Research is required to unlock this.'
                      : script.tip
                  }
                  disabled={script.research_required}
                  onClick={() =>
                    act('invoke', {
                      scriptureType: script.typepath,
                    })
                  }
                />
              </Table.Cell>
            </TableRow>
            <TableRow>
              <Table.Cell>{script.desc}</Table.Cell>
              <Table.Cell collapsing textAlign="right">
                <Button
                  fluid
                  content={'Quickbind'}
                  disabled={!script.purchased}
                  onClick={() =>
                    act('quickbind', {
                      scriptureType: script.typepath,
                    })
                  }
                />
              </Table.Cell>
            </TableRow>
            <Table.Cell>
              <Divider />
            </Table.Cell>
          </Fragment>
        ) : (
          <Box key={script} />
        ),
      )}
    </Table>
  );
};

const ClockworkOverview = (props) => {
  const { data } = useBackend();
  const { power, cogs, vitality, max_power, max_vitality } = data;
  return (
    <Box>
      <Box color="good" bold fontSize="16px">
        {'Celestial Gateway Report'}
      </Box>
      <Divider />
      <ClockworkOverviewStat
        title="Cogs"
        amount={cogs}
        maxAmount={10}
        iconName="cog"
        unit=""
      />
      <ClockworkOverviewStat
        title="Power"
        amount={power}
        maxAmount={max_power}
        iconName="battery-half "
        overrideText={convertPower(power)}
      />
      <ClockworkOverviewStat
        title="Vitality"
        amount={vitality}
        maxAmount={max_vitality}
        iconName="tint"
        unit="u"
      />
    </Box>
  );
};

const ClockworkOverviewStat = (props) => {
  const { title, iconName, amount, maxAmount, unit, overrideText } = props;
  return (
    <Box height="22px" fontSize="16px">
      <Stack>
        <Stack.Item width="8%">
          <Icon name={iconName} rotation={0} spin={0} />
        </Stack.Item>
        <Stack.Item width="20%">{title}</Stack.Item>
        <Stack.Item width="80%">
          <ProgressBar
            value={amount}
            minValue={0}
            maxValue={maxAmount}
            ranges={{
              good: [maxAmount / 2, Infinity],
              average: [maxAmount / 4, maxAmount / 2],
              bad: [-Infinity, maxAmount / 4],
            }}
          >
            {overrideText ? overrideText : amount + ' ' + unit}
          </ProgressBar>
        </Stack.Item>
      </Stack>
    </Box>
  );
};

const ClockworkButtonSelection = (props) => {
  const [selectedTab, setSelectedTab] = useLocalState('selectedTab', {});
  const tabs = ['Servitude', 'Preservation', 'Structures'];
  return (
    <Table>
      <Table.Row>
        {tabs.map((tab) => (
          <Table.Cell key={tab} collapsing>
            <Button key={tab} fluid onClick={() => setSelectedTab(tab)}>
              {tab}
            </Button>
          </Table.Cell>
        ))}
      </Table.Row>
    </Table>
  );
};
