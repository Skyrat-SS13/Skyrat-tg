import { useBackend } from "../backend";
import { Box } from "../components";
import { Window } from "../layouts";
import '../styles/themes/pulvencoder.scss';

type LatexEncoderData = {
// pin: Pin,
// programslist: List,
// pinprograms: List,
// pai_candidates: Candidate,
// latexprogram: LatexProgram,
}

export const LatexPulvEncoder = (props, context) => {
  const { act, data } = useBackend<LatexEncoderData>(context);
  return (
    <Window theme="pulvencoder" title="Latex pulv Encoder" width={420} height={732}>
      <Window.Content>
        <Box>  </Box>
      </Window.Content>
    </Window>
  );
};
