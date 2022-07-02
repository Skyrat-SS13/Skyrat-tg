import { useBackend } from '../backend';
import { Window } from '../layouts';
import { Dropdown, LabeledList, Section } from '../components';

export const NifPanel = (props, context) => {
  const { act, data } = useBackend(context);
  const { linked_mob_name } = data;
  return (
    <Window
      title={'Nanite Implant Frameworkk'}
      width={500}
      height={400}
      resizable>
      <Window.Content>
        <Section title={'Welcome to your NIF, ' + linked_mob_name} />
      </Window.Content>
    </Window>
  );
};

const NifSettings = (props, context) => {
  const { act, data };
  const { theme,
  product_notes,
  } = data;
  return(
    <LabeledList>
      <LabeledList.Item label="NIF Theme">
        <Dropdown />
      </LabeledList.Item>
    </LabeledList>
  );
};
