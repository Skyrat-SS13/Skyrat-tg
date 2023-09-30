import { BooleanLike } from 'common/react';
import { useBackend } from '../backend';
import { Icon, Section, Stack } from '../components';
import { Window } from '../layouts';
import { ObjectivePrintout, Objective, ReplaceObjectivesButton } from './common/Objectives';

const ninja_emphasis = {
  color: 'red',
};

type NinjaInfo = {
  objectives: Objective[];
  can_change_objective: BooleanLike;
};

// SKYRAT ADDITION <Rules />
export const AntagInfoNinja = (props, context) => {
  const { data } = useBackend<NinjaInfo>(context);
  const { objectives, can_change_objective } = data;
  return (
    <Window width={550} height={450} theme="hackerman">
      <Window.Content>
        <Icon
          size={30}
          name="spider"
          color="#003300"
          position="absolute"
          top="10%"
          left="10%"
        />
        <Section scrollable fill>
          <Stack vertical textColor="green">
            <Stack.Item textAlign="center" fontSize="20px">
              I am an elite mercenary of the Spider Clan.
              <br />A <span style={ninja_emphasis}> SPACE NINJA</span>!
            </Stack.Item>
            <Stack.Item textAlign="center" italic>
              Surprise is my weapon. Shadows are my armor. Without them, I am
              nothing.
            </Stack.Item>
            <Stack.Item>
              <Section fill>
                Your advanced ninja suit contains many powerful modules.
                <br /> It can be recharged by right clicking on station APCs or
                other power sources, in order to drain their battery.
                <br />
                Right clicking on some kinds of machines or items wearing your
                suit will hack them, to varying effect. Experiment and find out
                what you can do!
              </Section>
            </Stack.Item>
            <Stack.Item>
              <Rules />
            </Stack.Item>
            <Stack.Item>
              <ObjectivePrintout
                objectives={objectives}
                objectiveFollowup={
                  <ReplaceObjectivesButton
                    can_change_objective={can_change_objective}
                    button_title={'Adapt Mission Parameters'}
                    button_colour={'green'}
                  />
                }
              />
            </Stack.Item>
          </Stack>
        </Section>
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
          "- If your Spider-Clan issued C4 is for use in Engineering, use it as far away from the Supermatter as you can."
        }
      </Stack.Item>
      <Stack.Item>
        {
          "- Try not to hit the Atmos reservoirs either."
        }
      </Stack.Item>
      <Stack.Item>
        {
          "- It is standard procedure to incarcerate and more likely kill a Ninja as soon as their presence is made known."
        }
      </Stack.Item>
      <Stack.Item>
        {
          "- You are the only antagonist that prefers death before dishonor by nature. Your equipment is too valuable to fall into the crew’s hands. If you still have your Spider-clan issued C4, you’ll more than likely kill everyone within 6 tiles of you when you explode upon your death."
        }
      </Stack.Item>
      <Stack.Item>
        {
          "- Ninjas should not vent the entire station without an OPFOR that tells them they should. They should be mindful of where they doorjack and should avoid venting the majority of the station, even 'accidentally'. It can be considered griefing."
        }
      </Stack.Item>
      <Stack.Item bold>Metaprotections:</Stack.Item>
      <Stack.Item>
        {
          "Security has full knowledge of your equipment, including the standard issue suicide-grade explosives. Engineers, the CE, Roboticists, and the RD can tell when you’ve tampered with an APC. If you’re going stealthy about it, this can frame the AI as potentially Malf, or be dismissed as traitor activity, which it is. You’re to be considered a threat, even if you do say you’re here to protect someone."
        }
      </Stack.Item>
    </Stack>
  );
};
// [SKYRAT ADDITION END]
