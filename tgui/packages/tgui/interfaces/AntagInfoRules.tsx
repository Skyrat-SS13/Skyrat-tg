import { useBackend } from '../backend';
import { Stack } from '../components';
import { Objective } from './common/Objectives';

type Info = {
  antag_name: string;
  objectives: Objective[];
};

export const Rules = (props, context) => {
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
    case 'Blob':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Blob!_PERMANENT_MECHANICAL_STATE">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
      break;
    case 'Changeling':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Changeling!_Station_Threat">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'ClockCult':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Clockcult_(OPFOR)">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'AssaultOps':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Assault_Ops!">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Heretic':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Heretic!">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Malf AI':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Malf_AI!">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Morph':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Morphling!_Station_Threat">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Nightmare':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Nightmare!_Station_Threat">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Ninja':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Space_Ninja">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
    case 'Wizard':
      return (
        <Stack vertical>
          <Stack.Item bold>Special Rules:</Stack.Item>
          <Stack.Item>
            {
              <a href="https://wiki.skyrat13.space/index.php/Antagonist_Policy#Wizard!">
                Special Rules and Metaprotections!
              </a>
            }
          </Stack.Item>
        </Stack>
      );
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
