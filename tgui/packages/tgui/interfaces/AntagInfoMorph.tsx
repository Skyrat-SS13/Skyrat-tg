import { BlockQuote, Stack } from '../components';
import { Window } from '../layouts';

const goodstyle = {
  color: 'lightgreen',
};

const badstyle = {
  color: 'red',
};

const noticestyle = {
  color: 'lightblue',
};

// SKYRAT ADDITION <Rules />
export const AntagInfoMorph = (props, context) => {
  return (
    <Window width={620} height={170} theme="abductor">
      <Window.Content>
        <Stack vertical fill>
          <Stack.Item fontSize="25px">You are a morph...</Stack.Item>
          <Stack.Item>
            <BlockQuote>
              ...a shapeshifting abomination that can eat almost anything. You
              may take the form of anything you can see by{' '}
              <span style={noticestyle}>
                using your &quot;Assume Form&quot; ability on it. Shift-clicking
                the object in question will also work.
              </span>{' '}
              <span style={badstyle}>
                &ensp;This process will alert any nearby observers.
              </span>{' '}
              While morphed, you move faster, but are unable to attack creatures
              or eat anything. In addition,
              <span style={badstyle}>
                &ensp;anyone within three tiles will note an uncanny wrongness
                if examining you.
              </span>{' '}
              You can attack any item or dead creature to consume it -
              <span style={goodstyle}>
                &ensp;corpses will restore your health.
              </span>{' '}
              Finally, you can restore yourself to your original form while
              morphed by{' '}
              <span style={noticestyle}>
                using the &quot;Assume Form&quot; ability on yourself. You can
                also shift-click yourself.
              </span>{' '}
            </BlockQuote>
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
          "- For the sake of everyone’s sanity, don’t just rush the Silo."
        }
      </Stack.Item>
      <Stack.Item>
        {
          '- After your presence is confirmed, the Armory is fair game.'
        }
      </Stack.Item>
      <Stack.Item>
        {
          "- Don’t smash machinery just to eat the parts, unless that particular machine is being used against you."
        }
      </Stack.Item>
      <Stack.Item>
        {
          "- Do not be a BSA, or the DNA vault. Or the Grav Gen."
        }
      </Stack.Item>
      <Stack.Item>
        {
          "- Becomes PMS once they start eating (important stuff), or elsewise, attacking crew. (this will stick around until they can no longer eat techlathe-boards and the like)"
        }
      </Stack.Item>
      <Stack.Item bold>Metaprotections:</Stack.Item>
      <Stack.Item>
        {
          "Your existence is a notorious, consistent nuisance on a large number of stations. Aside from everyone knowing almost everything about you, only people in medical and science know that you slur when you imitate speech. Then again, everyone is going to find that strange anyway. Unless your disguise is mute."
        }
      </Stack.Item>
    </Stack>
  );
};
// [SKYRAT ADDITION END]
