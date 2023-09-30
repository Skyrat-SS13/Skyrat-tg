import { useBackend, useLocalState } from '../backend';
import { multiline } from 'common/string';
import { GenericUplink, Item } from './Uplink/GenericUplink';
import { BlockQuote, Button, Section, Stack, Tabs } from '../components';
import { BooleanLike } from 'common/react';
import { Window } from '../layouts';
import { ObjectivePrintout, Objective, ReplaceObjectivesButton } from './common/Objectives';

const allystyle = {
  fontWeight: 'bold',
  color: 'yellow',
};

const badstyle = {
  color: 'red',
  fontWeight: 'bold',
};

const goalstyle = {
  color: 'lightgreen',
  fontWeight: 'bold',
};

type Info = {
  has_codewords: BooleanLike;
  phrases: string;
  responses: string;
  theme: string;
  allies: string;
  goal: string;
  intro: string;
  processingTime: string;
  objectives: Objective[];
  categories: any[];
  can_change_objective: BooleanLike;
};

// SKYRAT ADDITION <Rules />
const IntroductionSection = (props, context) => {
  const { act, data } = useBackend<Info>(context);
  const { intro, objectives, can_change_objective } = data;
  return (
    <Section fill title="Intro" scrollable>
      <Stack vertical fill>
        <Stack.Item fontSize="25px">{intro}</Stack.Item>
        <Stack.Item grow>
          <ObjectivePrintout
            objectives={objectives}
            titleMessage="Your prime objectives:"
            objectivePrefix="&#8805-"
            objectiveFollowup={
              <ReplaceObjectivesButton
                can_change_objective={can_change_objective}
                button_title={'Overwrite Objectives Data'}
                button_colour={'green'}
              />
            }
          />
          <Rules />
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const FlavorSection = (props, context) => {
  const { data } = useBackend<Info>(context);
  const { allies, goal } = data;
  return (
    <Section
      fill
      title="Diagnostics"
      buttons={
        <Button
          mr={-0.8}
          mt={-0.5}
          icon="hammer"
          /* SKYRAT EDIT: ORIGINAL TOOLTIP
          tooltip={multiline`
            This is a gameplay suggestion for bored ais.
            You don't have to follow it, unless you want some
            ideas for how to spend the round.`}
          */
          tooltip={multiline`
            Please refer to the 'Antagonist Policy' section of the wiki
            if you have any questions.`}
          tooltipPosition="bottom-start">
          Policy
        </Button>
      }>
      <Stack vertical fill>
        <Stack.Item grow>
          <Stack fill vertical>
            <Stack.Item style={{ 'background-color': 'black' }}>
              <span style={goalstyle}>
                System Integrity Report:
                <br />
              </span>
              &gt;{goal}
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item grow style={{ 'background-color': 'black' }}>
              <span style={allystyle}>
                Morality Core Report:
                <br />
              </span>
              &gt;{allies}
            </Stack.Item>
            <Stack.Divider />
            <Stack.Item style={{ 'background-color': 'black' }}>
              <span style={badstyle}>
                Overall Sentience Coherence Grade: FAILING.
                <br />
              </span>
              &gt;Report to Nanotrasen?
              <br />
              &gt;&gt;N
            </Stack.Item>
          </Stack>
        </Stack.Item>
      </Stack>
    </Section>
  );
};

const CodewordsSection = (props, context) => {
  const { data } = useBackend<Info>(context);
  const { has_codewords, phrases, responses } = data;
  return (
    <Section title="Codewords" mb={!has_codewords && -1}>
      <Stack fill>
        {(!has_codewords && (
          <BlockQuote>
            You have not been supplied the Syndicate codewords. You will have to
            use alternative methods to find potential allies. Proceed with
            caution, however, as everyone is a potential foe.
          </BlockQuote>
        )) || (
          <>
            <Stack.Item grow basis={0}>
              <BlockQuote>
                New access to restricted channels has provided you with
                intercepted syndicate codewords. Syndicate agents will respond
                as if you&apos;re one of their own. Proceed with caution,
                however, as everyone is a potential foe.
                <span style={badstyle}>
                  &ensp;The speech recognition subsystem has been configured to
                  flag these codewords.
                </span>
              </BlockQuote>
            </Stack.Item>
            <Stack.Divider mr={1} />
            <Stack.Item grow basis={0}>
              <Stack vertical>
                <Stack.Item>Code Phrases:</Stack.Item>
                <Stack.Item bold textColor="blue">
                  {phrases}
                </Stack.Item>
                <Stack.Item>Code Responses:</Stack.Item>
                <Stack.Item bold textColor="red">
                  {responses}
                </Stack.Item>
              </Stack>
            </Stack.Item>
          </>
        )}
      </Stack>
    </Section>
  );
};

export const AntagInfoMalf = (props, context) => {
  const { act, data } = useBackend<Info>(context);
  const { processingTime, categories } = data;
  const [antagInfoTab, setAntagInfoTab] = useLocalState(
    context,
    'antagInfoTab',
    0
  );
  const categoriesList: string[] = [];
  const items: Item[] = [];
  for (let i = 0; i < categories.length; i++) {
    const category = categories[i];
    categoriesList.push(category.name);
    for (let itemIndex = 0; itemIndex < category.items.length; itemIndex++) {
      const item = category.items[itemIndex];
      items.push({
        id: item.name,
        name: item.name,
        category: category.name,
        cost: `${item.cost} PT`,
        desc: item.desc,
        disabled: processingTime < item.cost,
      });
    }
  }
  return (
    <Window
      width={660}
      height={530}
      theme={(antagInfoTab === 0 && 'hackerman') || 'malfunction'}>
      <Window.Content style={{ 'font-family': 'Consolas, monospace' }}>
        <Stack vertical fill>
          <Stack.Item>
            <Tabs fluid>
              <Tabs.Tab
                icon="info"
                selected={antagInfoTab === 0}
                onClick={() => setAntagInfoTab(0)}>
                Information
              </Tabs.Tab>
              <Tabs.Tab
                icon="code"
                selected={antagInfoTab === 1}
                onClick={() => setAntagInfoTab(1)}>
                Malfunction Modules
              </Tabs.Tab>
            </Tabs>
          </Stack.Item>
          {(antagInfoTab === 0 && (
            <>
              <Stack.Item grow>
                <Stack fill>
                  <Stack.Item width="70%">
                    <IntroductionSection />
                  </Stack.Item>
                  <Stack.Item width="30%">
                    <FlavorSection />
                  </Stack.Item>
                </Stack>
              </Stack.Item>
              <Stack.Item>
                <CodewordsSection />
              </Stack.Item>
            </>
          )) || (
            <Stack.Item>
              <Section>
                <GenericUplink
                  categories={categoriesList}
                  items={items}
                  currency={`${processingTime} PT`}
                  handleBuy={(item) => act('buy', { name: item.name })}
                />
              </Section>
            </Stack.Item>
          )}
        </Stack>
      </Window.Content>
    </Window>
  );
};

// [SKYRAT ADDITION BEGIN]
const Rules = (props, context) => {
  return (
    <Stack vertical>
      <Stack.Item bold>Special Rules:</Stack.Item>
      <Stack.Item>
        {
          '- Your “SSD” cyborg shells are open season. They aren’t protected by normal SSD rules.'
        }
      </Stack.Item>
      <Stack.Item>
        {
          '- You cannot activate Combat Indicator, barring being in a shell. Escalate accordingly.'
        }
      </Stack.Item>
      <Stack.Item>
        {'- Anyone touching your AI satellite is fair game.'}
      </Stack.Item>
      <Stack.Item>{'- Cyborgs on the Interlink do not exist.'}</Stack.Item>
      <Stack.Item>
        {
          '- During the Doomsday countdown, every cyborg on the station, and you, are in a PMS. There is fundamentally no time to discern between the good and bad in the moment, and the clock is ticking.'
        }
      </Stack.Item>
      <Stack.Item>
        {
          '- Cyborgs cannot and should not ahelp if they are abruptly flashed/destroyed/locked during Doomsday, due to the aforementioned rule. This PMS ends with the Delta alert.'
        }
      </Stack.Item>
      <Stack.Item>
        {
          '- A Cyborg Factory is a guaranteed outing of a Malf AI if the CE, RD, Engineers, or Roboticists find it.'
        }
      </Stack.Item>
      <Stack.Item>
        {
          '- You are allowed to blow your own borgs, if they came out of a factory.'
        }
      </Stack.Item>
      <Stack.Item>{'- YOU NEED AN ACCEPTED OPFOR TO DOOMSDAY.'}</Stack.Item>
      <Stack.Item>{'- You have to ahelp before ascending.'}</Stack.Item>
      <Stack.Item bold>Metaprotections:</Stack.Item>
      <Stack.Item>
        {
          'The Chief Engineer, Engineers, Research Director, and Roboticist, all know that blue APC’s are a bad thing. A very bad thing. It doesn’t necessarily mean that the AI is malf. But it is readily evident that it has been tampered with. It’s enough to cast suspicion at the AI, and lead to scrutiny. The RD and the Roboticists both know that Law 0 can exist, and should probably notice if new borgs are popping up out of nowhere. The RD and the CE are both allowed to be the ones that make the call that the AI is Malf. The RD is the go-to person that should scrutinize the AI. If a Roboticist, RD, CE, or Engineer happens to find a Cyborg Factory, the cat is out of the bag if they can report it. Equipment that has no business exploding, like scrubbers, holopads, or the booze-o-mat is a tell-tell sign that the AI is malfunctioning. If every RCD explodes, the AI is definitely Malf.'
        }
      </Stack.Item>
    </Stack>
  );
};
// [SKYRAT ADDITION END]
