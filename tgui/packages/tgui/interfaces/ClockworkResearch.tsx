import { useBackend } from '../backend';
import { Box, Button, Section, Stack, Divider, Flex } from '../components';
import { Window } from '../layouts';
import { BooleanLike, classes } from '../../common/react';

type Data = {
  research_tiers: Array<Array<Research>>;
  starting_research: Research;
  focused_research: Research;
  in_area: BooleanLike;
};

type Research = {
  name: string;
  desc: string;
  lore: string;
  starting: BooleanLike;
  researched: BooleanLike;
  can_research: BooleanLike;
  research_location: string;
  research_designs: Array<DesignInfo>;
  research_scriptures: Array<DesignInfo>;
  type: string;
};

type DesignInfo = {
  name: string;
  icon: string;
  icon2: string;
};

const MainData = () => {
  return (
    <>
      <Section>
        <div className="Selection">
          <SelectedSection />
        </div>
        <br />
      </Section>
      <Section height="100%">
        <div className="Research">
          <ResearchSection />
        </div>
      </Section>
    </>
  );
};

const SelectedSection = (props) => {
  const { act, data } = useBackend<Data>();
  return (
    <Box>
      <div style={{ 'text-align': 'center' }}>
        <Box color="good" bold fontSize="16px">
          {'Selected Research'}
        </Box>
        <Divider />
        <Box bold fontSize="14px">
          {data.focused_research.name}
        </Box>
        <Box>{data.focused_research.desc}</Box>
        <div style={{ 'padding-top': '5px' }}>
          <Box>
            <i>{data.focused_research.lore}</i>
          </Box>
        </div>
        <br />
        {data.focused_research.starting ? (
          <Box>This does not need to be researched.</Box>
        ) : data.focused_research.researched ? (
          <Box>
            This ritual occurred in the{' '}
            <b>{data.focused_research.research_location}</b>.
          </Box>
        ) : (
          <Box>
            This ritual must occur in the{' '}
            <b>{data.focused_research.research_location}</b>.
          </Box>
        )}
        <br />
        <Box fontSize="18px">
          <Button
            disabled={!data.in_area || data.focused_research.researched}
            content={
              data.focused_research.researched
                ? 'Ritual Completed'
                : 'Begin Ritual'
            }
            onClick={() => act('start_research')}
          />
        </Box>
      </div>
    </Box>
  );
};

const ResearchSection = (props) => {
  const { act, data } = useBackend<Data>());
  return (
    <Stack vertical>
      <Stack.Item fill>
        <Section fill title="Basic Research">
          <div style={{ 'text-align': 'center' }}>
            {ResearchNode(data.starting_research, act)}
          </div>
        </Section>
      </Stack.Item>
      {data.research_tiers.map((inside_array: Array<Research>) => (
        <Stack vertical fill key={inside_array[0].name}>
          <Section
            title={`Tier ${data.research_tiers.indexOf(inside_array) + 1}`}>
            {inside_array.map((single_research: Research) => (
              <Stack.Item key={single_research.name}>
                <Section fill>
                  <div style={{ 'text-align': 'center' }}>
                    {ResearchNode(single_research, act)}
                  </div>
                </Section>
              </Stack.Item>
            ))}
          </Section>
        </Stack>
      ))}
    </Stack>
  );
};

const ResearchNode = (research: Research, act: any) => {
  return (
    <Box>
      <Stack.Item bold fontSize="15px">
        <Button
          disabled={!research.can_research}
          content={research.name}
          icon={research.researched ? 'check' : ''}
          iconPosition="right"
          onClick={() => act('select_research', { path: research.type })}
        />
      </Stack.Item>
      <Stack.Item>
        <div style={{ 'padding-top': '6px' }}>{research.desc}</div>
      </Stack.Item>
      <br />
      <Stack.Item>
        <Box>
          <Flex className="ClockResearch__IconContent">
            {research.research_designs.map(
              (design_data: DesignInfo, i: number) => (
                <div className="ClockResearch__Icon" key={design_data.name}>
                  <Button
                    className={classes([`design32x32`, design_data.icon2])} // swap back to clockresearch when it's not absolutely broken
                    tooltip={`${design_data.name} (Tinker's Design)`}
                    tooltipPosition={i % 15 < 7 ? 'right' : 'left'}
                  />
                </div>
              )
            )}
            {research.research_scriptures.map(
              (scripture_data: DesignInfo, i: number) => (
                <div className="ClockResearch__Icon" key={scripture_data.name}>
                  <Button
                    className={classes([`design32x32`, scripture_data.icon2])} // swap back to clockresearch when it's not absolutely broken
                    tooltip={`${scripture_data.name} (Scripture)`}
                    tooltipPosition={i % 15 < 7 ? 'right' : 'left'}
                  />
                </div>
              )
            )}
          </Flex>
        </Box>
      </Stack.Item>
    </Box>
  );
};

export const ClockworkResearch = (props) => {
  return (
    <Window theme="clockwork" width={400} height={750}>
      <Window.Content>{MainData()}</Window.Content>
    </Window>
  );
};
