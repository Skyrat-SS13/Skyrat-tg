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
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Abductors!_Station_Threat">
                Special Rules and Metaprotections!
              </a>
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
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Contractor!">
                Special Rules and Metaprotections!
              </a>
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
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Cortical_Borer!_PERMANENT_MECHANICAL_STATE">
                Special Rules and Metaprotections!
              </a>
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
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Man_Eaters!_PERMANENT_MECHANICAL_STATE">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Obsessed':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Obsessed!">
                Special Rules and Metaprotections!
              </a>
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
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Revenant!_PERMANENT_MECHANICAL_STATE">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Space Dragon':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Space_Dragon!_PERMANENT_MECHANICAL_STATE">
                Special Rules and Metaprotections!
              </a>
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
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Space_Pirates!_Station_Threat">
                Special Rules and Metaprotections!
              </a>
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
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Traitor!">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
  }
};
// SKYRAT EDIT ADDITION END
