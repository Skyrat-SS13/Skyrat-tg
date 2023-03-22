import { useBackend } from '../backend';
import { BooleanLike } from 'common/react';
import { Section, NoticeBox } from '../components';
import { Window } from '../layouts';

type ICESData = {
  current_credits: number;
  ckey: string;
  is_fun: BooleanLike;
};

type Props = {
  context: any;
};

export const IntensityCredits = (props, context) => {
  const { act, data } = useBackend<ICESData>(context);

  const { ckey, current_credits, is_fun } = data;

  return (
    <Window title="ICES Events Panel" width={480} height={320} theme="admin">
      <Window.Content>
        <Section title="Configuration">
          <NoticeBox>
            You thought there would be something useful here?
            <br />
            Ha! What a loser. :3
          </NoticeBox>
        </Section>
      </Window.Content>
    </Window>
  );
};
