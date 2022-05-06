import { sortBy } from 'common/collections';
import { useBackend } from '../backend';
import { Box, Button, Section, Table, Icon } from '../components'; // SKYRAT EDIT - ORIGINAL: import { Box, Button, Section, Colorbox Table }
import { COLORS } from '../constants';
import { Window } from '../layouts';


const HEALTH_COLOR_BY_LEVEL = [
  '#17d568',
  '#c4cf2d', // SKYRAT EDIT - Original'#2ecc71' - moved to make it visually different,
  '#e67e22',
  '#ed5100',
  '#e74c3c',
  '#801308', // SKYRAT EDIT - Original'#ed2814' - darker to help distinguish better,
];
// SKYRAT ADDITION  - Icon status list
const HEALTH_ICON_BY_LEVEL = [
  'heart',
  'heart',
  'heart',
  'heart',
  'heartbeat',
  'skull',
];
// SKRAY ADDITION - END:
const jobIsHead = jobId => jobId % 10 === 0;

const jobToColor = jobId => {
  if (jobId === 0) {
    return COLORS.department.captain;
  }
  if (jobId >= 10 && jobId < 20) {
    return COLORS.department.security;
  }
  if (jobId >= 20 && jobId < 30) {
    return COLORS.department.medbay;
  }
  if (jobId >= 30 && jobId < 40) {
    return COLORS.department.science;
  }
  if (jobId >= 40 && jobId < 50) {
    return COLORS.department.engineering;
  }
  if (jobId >= 50 && jobId < 60) {
    return COLORS.department.cargo;
  }
  // SKYRAT EDIT - Crew Monitor Updates to add Service Dept
  if (jobId >= 60 && jobId < 80) {
    return COLORS.department.service;
  }
  // SKYRAT EDIT - ORIGINAL: if (jobId >= 200 && jobId < 230) {
  if (jobId >= 200 && jobId < 240) {
    return COLORS.department.centcom;
  }
  return COLORS.department.other;
};

// SKYRAT EDIT - START:
const healthToAttribute = (oxy, tox, burn, brute, attributeList) => {
  const healthSum = oxy + tox + burn + brute;
  const level = Math.min(Math.max(Math.ceil(healthSum / 31), 0), 5);
  // SKYRAT EDIT END: Health bump from 25 to 31 for SR's health pool
  return attributeList[level];
};


const HealthStat = props => {
  const { type, value } = props;
  return (
    <Box
      inline
      width={2}
      color={COLORS.damageType[type]}
      textAlign="center">
      {value}
    </Box>
  );
};

export const CrewConsole = () => {
  return (
    <Window
      title="Crew Monitor"
      width={600}
      height={600}>
      <Window.Content scrollable>
        <Section minHeight="540px">
          <CrewTable />
        </Section>
      </Window.Content>
    </Window>
  );
};

const CrewTable = (props, context) => {
  const { act, data } = useBackend(context);
  const sensors = sortBy(
    s => s.ijob
  )(data.sensors ?? []);
  return (
  // SKYRAT EDIT START - Various adjustments to re-align columns
    <Table cellpadding="3" >{/* SKYRAT EDIT - gives a buffer to flush text*/}
      <Table.Row>
        <Table.Cell bold colspan="2" > {/* SKYRAT EDIT - Expands the first column to account for robotic wrench*/}
          Name
        </Table.Cell>
        <Table.Cell bold collapsing textAlign="center"> {/* SKYRAT EDIT - Removal of false column and changes to alignment*/}
          Status
        </Table.Cell>
        <Table.Cell bold collapsing textAlign="center">
          Vitals
        </Table.Cell>
        <Table.Cell bold width="180px" collapsing textAlign="center">{/* SKYRAT EDIT - Centers the text*/}
          Position
        </Table.Cell>
      </Table.Row>
      {sensors.map(sensor => (
        <CrewTableEntry sensor_data={sensor} key={sensor.ref} />
      ))}

    </Table>
  // SKYRAT EDIT START - Various adjustments to re-align columns
  );
};

const CrewTableEntry = (props, context) => {
  const { act, data } = useBackend(context);
  const { link_allowed } = data;
  const { sensor_data } = props;
  const {
    name,
    assignment,
    ijob,
    is_robot, // SKYRAT EDIT ADDITION - Displaying robotic species Icon
    life_status,
    oxydam,
    toxdam,
    burndam,
    brutedam,
    area,
    can_track,
  } = sensor_data;

  return (
    <Table.Row>
      <Table.Cell
        bold={jobIsHead(ijob)}
        color={jobToColor(ijob)}>
        {name}{assignment !== undefined ? ` (${assignment})` : ""}
      </Table.Cell>
      {/* SKYRAT EDIT START - Displaying robotic species Icon */}
      <Table.Cell collapsing textAlign="center">
        {is_robot ? <Icon name="wrench" color="#B7410E" size={1} /> : ""}
      </Table.Cell>
      {/* SKYRAT EDIT END */}
      <Table.Cell collapsing textAlign="center">
        {/* SKYRAT EDIT START - Displaying status Icons */}
        {oxydam !== undefined ? (
          <Icon
            name={healthToAttribute(
              oxydam,
              toxdam,
              burndam,
              brutedam,
              HEALTH_ICON_BY_LEVEL)}
            color={healthToAttribute(
              oxydam,
              toxdam,
              burndam,
              brutedam,
              HEALTH_COLOR_BY_LEVEL)}
            size={1} />
        ) : (
          life_status ? (
            <Icon name="heart" color="#17d568" size={1} />
          ) : (
            <Icon name="skull" color="#B7410E" size={1} />
          ))}
        {/* SKYRAT EDIT END */}
      </Table.Cell>
      <Table.Cell collapsing textAlign="center">
        {oxydam !== undefined ? (
          <Box inline>
            <HealthStat type="oxy" value={oxydam} />
            {'/'}
            <HealthStat type="toxin" value={toxdam} />
            {'/'}
            <HealthStat type="burn" value={burndam} />
            {'/'}
            <HealthStat type="brute" value={brutedam} />
          </Box>
        ) : (
          life_status ? 'Alive' : 'Dead'
        )}
      </Table.Cell>
      <Table.Cell>
        {area !== undefined ? area : <Icon name="question" color="#ffffff" size={1} /> } {/* SKYRAT EDIT - Icon from text 'N/A'*/}
      </Table.Cell>
      {!!link_allowed && (
        <Table.Cell collapsing>
          <Button
            content="Track"
            disabled={!can_track}
            onClick={() => act('select_person', {
              name: name,
            })} />
        </Table.Cell>
      )}
    </Table.Row>
  );
};
