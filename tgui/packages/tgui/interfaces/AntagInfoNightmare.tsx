import { BlockQuote, LabeledList, Section, Stack } from '../components';
import { Window } from '../layouts';

const tipstyle = {
  color: 'white',
};

const noticestyle = {
  color: 'lightblue',
};

// SKYRAT ADDITION <Rules />
export const AntagInfoNightmare = (props, context) => {
  return (
    <Window width={620} height={340}>
      <Window.Content backgroundColor="#0d0d0d">
        <Stack fill>
          <Stack.Item width="46.2%">
            <Section fill>
              <Stack vertical fill>
                <Stack.Item fontSize="25px">You are a Nightmare.</Stack.Item>
                <Stack.Item>
                  <BlockQuote>
                    You are a creature from beyond the stars that has incredibly
                    strong powers in the darkness, becoming nigh unbeatable.
                    Unfortunately, you wither and burn away in the light. You
                    must use your
                    <span style={noticestyle}>&ensp;light eater</span> to dim
                    the station, making hunting easier.
                  </BlockQuote>
                </Stack.Item>
                <Stack.Divider />
                <Stack.Item textColor="label">
                  <span style={tipstyle}>Tip #1:&ensp;</span>
                  Move often. The station will be hunting you after you are
                  discovered, so don&apos;t stay in one area for long.
                  <br />
                  <span style={tipstyle}>Tip #2:&ensp;</span>
                  Pick unfair fights. You are incredibly strong in one versus
                  one situations, use it. The more you fight, the harder it will
                  be to keep it dark.
                  <br />
                  <span style={tipstyle}>Tip #3:&ensp;</span>
                  Fully destroy APCs when possible. Instead of hunting lights
                  that can be fixed, hunt the APCs which are harder to repair.
                </Stack.Item>
              </Stack>
            </Section>
          </Stack.Item>
          <Stack.Item width="53%">
            <Section fill title="Powers">
              <LabeledList>
                <LabeledList.Item label="Shadow Dance">
                  Whilst in the shadows, you are immune to all ranged attacks,
                  whilst also rapidly regenerating health.
                </LabeledList.Item>
                <LabeledList.Item label="Shadow Walk">
                  You are allowed unlimited, unrestricted movement in the dark.
                  Light will pull you out of this.
                </LabeledList.Item>
                <LabeledList.Item label="Heart of Darkness">
                  Your heart invites the shadows. If you die in the darkness,
                  you will eventually revive if left alone.
                </LabeledList.Item>
                <LabeledList.Item label="Light Eater">
                  Your twisted appendage. It will consume the light of what it
                  touches, be it victim or object.
                </LabeledList.Item>
              </LabeledList>
            </Section>
          </Stack.Item>
          <Stack.Item>
            <Rules />
          </Stack.Item>
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
          '- Breaking APC’s is fine, but don’t Destroy them completely until after hostilities have begun.'
        }
      </Stack.Item>
      <Stack.Item>
        {
          '- Being able to easily jaunt and escape means you can easily be placed in a Permanent Mechanical State.'
        }
      </Stack.Item>
      <Stack.Item>
        {
          '- You are literally a horror from another plane that is naturally malevolent towards light and those that use it.'
        }
      </Stack.Item>
      <Stack.Item>
        {
          '- People who insist on shining light on you while emoting for 30 seconds can’t complain if you stab them for it.'
        }
      </Stack.Item>
      <Stack.Item bold>Metaprotections:</Stack.Item>
      <Stack.Item>
        {
          'The Chaplain and Curator have full knowledge of you, your abilities, and what you are. They aren’t your friends. Medical and Science also know your organs are quite valuable. Engineering knows what your kind does to stations, and they naturally hate your guts for it. Security could care less what you are, and only care if you get violent. Which you likely will.'
        }
      </Stack.Item>
    </Stack>
  );
};
// [SKYRAT ADDITION END]
