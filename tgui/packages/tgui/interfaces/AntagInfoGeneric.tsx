import { useBackend } from '../backend';
import { Section, Stack } from '../components';
import { Window } from '../layouts';
import { ObjectivePrintout, Objective } from './common/Objectives';

type Info = {
  antag_name: string;
  objectives: Objective[];
};

// SKYRAT EDIT increase height from 250 to 500
export const AntagInfoGeneric = (props, context) => {
  const { data } = useBackend<Info>(context);
  const { antag_name, objectives } = data;
  return (
    <Window width={620} height={500}>
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item textColor="red" fontSize="20px">
              You are the {antag_name}!
            </Stack.Item>
            {/* SKYRAT EDIT ADDITION START */}
            <Stack.Item>
              <Rules />
            </Stack.Item>
            {/* SKYRAT EDIT ADDITION END */}
            <Stack.Item>
              <ObjectivePrintout objectives={objectives} />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};

// SKYRAT EDIT ADDITION START
const Rules = (props, context) => {
  const { data } = useBackend<Info>(context);
  const { antag_name } = data;
  switch (antag_name) {
    case 'Abductor Agent' || 'Abductor Scientist' || 'Abductor Solo':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              '- Essentially, picture Destroy All Humans(game series) without the personality, and you have the right idea.'
            }
          </Stack.Item>
          <Stack.Item>
            {
              '- Functionally PMS once called out, but you should avoid just running around doing nothing but mechanics if possible.'
            }
          </Stack.Item>
          <Stack.Item>
            {
              "- You're very-PMS if you're openly using your gear, this includes the tools or elsewise, so no, the crew do not have to wait for you to hack the door open before running away."
            }
          </Stack.Item>
          <Stack.Item bold>Metaprotections:</Stack.Item>
          <Stack.Item>
            {
              '- The Science department knows that Grays consistently steal away people for strange experiments. They are familiar with their ability to teleport on-station, as well as disguise themselves. They know that people abruptly appearing detained in strange places can be a sure sign of a freshly experimented-on crewmember. Especially if their memory is gone, or they’re acting strange. They also know they can’t speak vocally.'
            }
          </Stack.Item>
          <Stack.Item>
            {
              "- The Medical department: Is aware of Abductors, and their habit for replacing organs, once they're confirmed, medical should be on the prowl for people behaving weirdly, or else-wise, vanishing for periods of time, essentially:, everything science knows."
            }
          </Stack.Item>
          <Stack.Item>
            {
              '- The Security department is aware of an alien species prone to abducting crew, and that you have to go above-and-beyond with them to put them down, due to their advanced armors.'
            }
          </Stack.Item>
          <Stack.Item>
            {
              "- Everyone knows that abductors are bad-news-bears, have a bad habit of appearing where you don't want to be, and elsewise, know it's a good habit to disable your cameras if they're about, because they have a funny habit of tapping into them."
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Drifting Contractor':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              "- You are bound to the same rules as other antags; that means you shouldn't just decide to blow up the SM because you feel like it, regardless of if you can afford a bomb or not, and stick to your goal of kidnapping."
            }
          </Stack.Item>
          <Stack.Item>
            {
              "- Confirmed contractors can be checked for their modsuit, regardless of it's stealth-status."
            }
          </Stack.Item>
          <Stack.Item bold>Metaprotections:</Stack.Item>
          <Stack.Item>
            {
              'None: everyone knows what the gear* is, and whom uses it, syndicate contractors.'
            }
          </Stack.Item>
          <Stack.Item>
            {
              'https://wiki.skyrat13.space/index.php/Corporate_Regulations#Contraband_Table'
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Cortical Borer':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              '- You are in a permanent mechanical state at all times. You do not need to CI. No one needs to CI vs you.'
            }
          </Stack.Item>
          <Stack.Item>
            {'- You do not need to roleplay prior to infestation.'}
          </Stack.Item>
          <Stack.Item>
            {
              '- You are allowed to kill your host if they threaten you, regardless of whether or not they were willing or unwilling, originally.'
            }
          </Stack.Item>
          <Stack.Item>
            {'- It is not a good idea to produce an Egg in a large crowd.'}
          </Stack.Item>
          <Stack.Item>{'- Do not crawl into SSD people.'}</Stack.Item>
          <Stack.Item>
            {'- Do not crawl into people in the middle of ERP.'}
          </Stack.Item>
          <Stack.Item bold>Metaprotections:</Stack.Item>
          <Stack.Item>
            {
              'Cortical Borers are well-known by everyone, but only characters with a deep medical or science background know that sugar can render them temporarily comatose for removal. They also know that Cortical Borers don’t take kindly to that, and that they’re theoretically replaceable.'
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Venus Human Trap':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              '- Do not drag bodies deeper into the vines. Leave them where they fall. Also do not move them somewhere safer.'
            }
          </Stack.Item>
          <Stack.Item>
            {
              '- Do not chase anyone past a point where you can’t see your vines.'
            }
          </Stack.Item>
          <Stack.Item>
            {
              '- If you spawn as a result of seeding, immediately beat the shit out of the nearest person.'
            }
          </Stack.Item>
          <Stack.Item>
            {
              '- You are in a permanent mechanical state at all times. CI isn’t necessary, nor is RP. The vines don’t stop growing.'
            }
          </Stack.Item>
          <Stack.Item>{'- Avoid goats.'}</Stack.Item>
          <Stack.Item bold>Metaprotections:</Stack.Item>
          <Stack.Item>{'You’re just a plant.'}</Stack.Item>
        </Stack>
      );
      break;
    case 'Obsessed':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              '- Don’t interrupt ERP to get at your obsessed target. Admins can just change the target on request.'
            }
          </Stack.Item>
          <Stack.Item>
            {'- Yes you’re allowed to be obsessed as a head of staff.'}
          </Stack.Item>
          <Stack.Item bold>Metaprotections:</Stack.Item>
          <Stack.Item>
            {
              'Medical can remove this antagonist entirely from you by just scanning your brain, checking for schizophrenia, and promptly removing it. It’s also something that they should be looking for, especially towards the middle of the shift. The Psychologist is theoretically your best friend and enemy for roleplay purposes.'
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Revenant':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              '- You can subtle (hearable) while not manifested, as well as view exploitable information as well.'
            }
          </Stack.Item>
          <Stack.Item bold>Metaprotections:</Stack.Item>
          <Stack.Item>
            {
              'The Curator and Chaplain both have complete knowledge of what you are and what you’re capable of, and just as well, the Chaplain can, will, and should hunt you down. Everyone at the very least can know that the ashes left behind by the Revenant should be scattered to dismiss it. Aside from scattering ashes, however, the Curator and Chaplain, as well as CC, are the only people who know a Revenant’s weaknesses… besides just shooting them.'
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Space Dragon':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>{'- Don’t go on the Emergency Shuttle.'}</Stack.Item>
          <Stack.Item>
            {
              '- Protect your portals closely, residing nearby them as much as you can.'
            }
          </Stack.Item>
          <Stack.Item>
            {
              '- You are smart enough and old enough to know that most other races don’t like being exposed to space.'
            }
          </Stack.Item>
          <Stack.Item>{'- Dead carp are a valid source of health.'}</Stack.Item>
          <Stack.Item>
            {
              '- You’re in a permanently mechanical state, by virtue of your whole gimmick being a race against the clock.'
            }
          </Stack.Item>
          <Stack.Item bold>Metaprotections:</Stack.Item>
          <Stack.Item>
            {
              'You’re a well known threat. There’s not much to know about you other than portals are bad, carps are bad, being on fire is bad, and you can die, so killing you is an option. One the crew will immediately spring for.'
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Space Pirate':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              "- You come with a giant announcement telling everyone you're here for a fight, so expect to be attacked almost instantly, this means while you are not PMS; you are also not protected from validhunting in general, as you are actively a threat to everyone. The only exception is the 'NRI Police' / 'NRI Patrol' variation of pirates, which announce more neutral terms."
            }
          </Stack.Item>
          <Stack.Item>
            {
              "- You shouldn't just rush the armory/the SM, and should primarily focus on 'establishing contact', or else-wise, getting that loot."
            }
          </Stack.Item>
          <Stack.Item>
            {"- Just because you can sell crew, doesn't mean you should."}
          </Stack.Item>
          <Stack.Item>
            {
              "- No, the 'space IRS' is not a government entity, no they are not from solfed, or NT."
            }
          </Stack.Item>
          <Stack.Item bold>Metaprotections:</Stack.Item>
          <Stack.Item>
            {
              "none; you literally come fresh with a massive announcement telling everyone you're here for a fight."
            }
          </Stack.Item>
        </Stack>
      );
      break;
    default:
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              "- Most of your actions should be focused around your objectives, or the people directly related to them, you shouldn't be going after randoms, or bombing medbay just to do it."
            }
          </Stack.Item>
          <Stack.Item>
            {
              "- If you want to do something targeting a player in specific, a department at large, or the station at large, make an opfor, else-wise, opfors are only required for actions of high-intensity (see: breaking into engineering and stealing the protolathe), where as low intensity (emagging into engineering and printing jaws) doesn't"
            }
          </Stack.Item>
          <Stack.Item>
            {
              "- Regardless of having very-forward objectives, you should be trying to generate as much RP as you can while doing them, even something as simple as 'steal the hand tele' can have a story spark from it with a bit of effort."
            }
          </Stack.Item>
          <Stack.Item bold>Metaprotections:</Stack.Item>
          <Stack.Item>
            {'- https://wiki.skyrat13.space/w/index.php/Contraband'}
          </Stack.Item>
          <Stack.Item>
            {
              "- If it's not in contraband, it's either not illegal, or else-wise unknown, and should be treated as it appears."
            }
          </Stack.Item>
        </Stack>
      );
      break;
  }
};
// SKYRAT EDIT ADDITION END
