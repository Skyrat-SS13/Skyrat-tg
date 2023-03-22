import { useBackend } from '../backend';
import { BooleanLike } from 'common/react';
import { Section } from '../components';
import { Window } from '../layouts';

type ICESData = {
  current_credits: number;
  ckey: string;
  is_fun: BooleanLike;
};

export const IntensityCredits = (props, context) => {
  const { data } = useBackend<ICESData>(context);

  const { current_credits, ckey, is_fun } = data;

  return (
    <Window title="ICES Events Panel" width={480} height={320} theme="admin">
      <Window.Content>
        <Section title="Configuration">
          You thought there would be something useful here? Ha! What a loser. :3
        </Section>
      </Window.Content>
    </Window>
  );
};
