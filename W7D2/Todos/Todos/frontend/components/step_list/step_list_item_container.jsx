import { connect } from 'react-redux';
import StepListItem from './step_list_item';
// Actions
import { updateStep, deleteStep } from '../../actions/step_actions';

const mapDispatchToProps = (dispatch, { step }) => ({
  deleteStep: () => dispatch(deleteStep(step)),
  updateStep: (upStep) => dispatch(updateStep(upStep))
});

export default connect(
  null, // step prop is already passed in
  mapDispatchToProps
)(StepListItem);
