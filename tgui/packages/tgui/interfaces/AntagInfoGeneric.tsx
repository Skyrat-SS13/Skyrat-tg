import { Section, Stack } from 'tgui-core/components';

import { useBackend } from '../backend';
import { Window } from '../layouts';
<<<<<<< HEAD
import { Rules } from './AntagInfoRules'; // SKYRAT EDIT ADDITION
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
import { Objective, ObjectivePrintout } from './common/Objectives';

type Info = {
  antag_name: string;
  objectives: Objective[];
};

<<<<<<< HEAD
// SKYRAT EDIT increase height from 250 to 500
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
export const AntagInfoGeneric = (props) => {
  const { data } = useBackend<Info>();
  const { antag_name, objectives } = data;
  return (
<<<<<<< HEAD
    <Window width={620} height={500}>
=======
    <Window width={620} height={250}>
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
      <Window.Content>
        <Section scrollable fill>
          <Stack vertical>
            <Stack.Item textColor="red" fontSize="20px">
              You are the {antag_name}!
            </Stack.Item>
<<<<<<< HEAD
            {/* SKYRAT EDIT ADDITION START */}
            <Stack.Item>
              <Rules />
            </Stack.Item>
            {/* SKYRAT EDIT ADDITION END */}
=======
>>>>>>> 4b4ae0958fe6b5d511ee6e24a5087599f61d70a3
            <Stack.Item>
              <ObjectivePrintout objectives={objectives} />
            </Stack.Item>
          </Stack>
        </Section>
      </Window.Content>
    </Window>
  );
};
