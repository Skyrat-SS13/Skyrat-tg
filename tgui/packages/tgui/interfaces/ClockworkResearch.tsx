import { useBackend } from '../backend';
import { Box, Stack } from '../components';
import { Window } from '../layouts';
import { BooleanLike } from '../../common/react';

type Data = {
  research: Array<Research>;
};

type Research = {
  name: string;
  desc: string;
  starting: BooleanLike;
  researched: BooleanLike;
  tier: number;
};

const brassColor = '#DFC69C';
const tinkerCache = '#B5FD9D';
const replicaFab = '#DED09F';
const clockMarauder = '#FF9D9D';

let starting_research: Research;
let research_tiers: Map<number, Array<string>>;

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

const Connections = (research_list) => {
  research_list.forEach((research: Research) => {
    if (research.starting) {
      starting_research = research;
      return; /* Check if this does what it says */
    }

    if (research.tier.toString() in research_tiers) {
      research_tiers[research.tier.toString()] += research;
    } else {
      research_tiers[research.tier.toString()] = [research];
    }
  });
};

const MainData = () => {
  return (
    <Stack>
      <Stack.Item>{ResearchNode(starting_research)}</Stack.Item>
      {Object.keys(research_tiers).forEach((tier_num: any) => {
        {
          research_tiers[tier_num].map((single_research: Research) => (
            <Stack.Item key={single_research.name}>
              {ResearchNode(single_research)}
            </Stack.Item>
          ));
        }
      })}
    </Stack>
  );
};

const ResearchNode = (research: Research) => {
  return (
    <Box>
      <Stack vertical>
        <Stack.Item bold>{research.name}</Stack.Item>
        <Stack.Item>{research.desc}</Stack.Item>
      </Stack>
    </Box>
  );
};

export const ClockworkResearch = (props, context) => {
  const { act, data } = useBackend<Data>(context);
  Connections(data.research);
  return (
    <Window theme="clockwork">
      <Window.Content>{MainData()}</Window.Content>
    </Window>
  );
};
