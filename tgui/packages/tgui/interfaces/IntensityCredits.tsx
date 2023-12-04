import { useBackend } from '../backend';
import { Section, NoticeBox, Flex } from '../components';
import { Window } from '../layouts';

type ICESData = {
  current_credits: number;
  next_run: string;
  active_players: number;
  lowpop_players: number;
  lowpop_multiplier: number;
  midpop_players: number;
  midpop_multiplier: number;
  highpop_players: number;
  highpop_multiplier: number;
};

type Props = {
  context: any;
};

export const IntensityCredits = (props) => {
  const { act, data } = useBackend<ICESData>();

  const {
    current_credits,
    next_run,
    active_players,
    lowpop_players,
    lowpop_multiplier,
    midpop_players,
    midpop_multiplier,
    highpop_players,
    highpop_multiplier,
  } = data;

  return (
    <Window title="ICES Events Panel" width={480} height={320} theme="admin">
      <Window.Content>
        <Section title="Status">
          <Flex direction="column">
            <Flex.Item>Intensity Credits: {current_credits}</Flex.Item>
            <Flex.Item>Next Event: {next_run}</Flex.Item>
            <Flex.Item>Active Players: {active_players}</Flex.Item>
            <Flex.Item>Highpop Threshold: {highpop_players}</Flex.Item>
            <Flex.Item>Highpop Multiplier: {highpop_multiplier}x</Flex.Item>
            <Flex.Item>Midpop Threshold: {midpop_players}</Flex.Item>
            <Flex.Item>Midpop Multiplier: {midpop_multiplier}x</Flex.Item>
            <Flex.Item>Lowpop Threshold: {lowpop_players}</Flex.Item>
            <Flex.Item>Lowpop Multiplier: {lowpop_multiplier}x</Flex.Item>
          </Flex>
        </Section>
        <Section title="Configuration">
          <NoticeBox>
            You thought there would be something useful here?
            <br />
            Ha! What a loser. :3
          </NoticeBox>
        </Section>
      </Window.Content>
    </Window>
  );
};
