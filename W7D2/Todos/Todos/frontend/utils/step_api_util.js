export const requestSteps = (step) => (
  $.ajax({
    method: "GET",
    url: 'api/steps',
    data: step
  })
);

export const postStep = (step) => (
  $.ajax({
    method: "POST",
    url: 'api/steps',
    data: step
  })
);

export const updateStep = (step) => (
  $.ajax({
    method: "PATCH",
    url: `api/steps/${step.id}`,
    data: step
  })
);

export const deleteStep = (step) => (
  $.ajax({
    method: "DELETE",
    url: `api/steps/${step.id}`,
  })
);
