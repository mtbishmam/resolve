import { authorizeBrowserRequest } from "@/lib/auth";
import { RecordReviewSchema } from "@/lib/contracts";
import { recordReview } from "@/db/queries";

export async function POST(request: Request) {
  if (!(await authorizeBrowserRequest(request))) {
    return Response.json({ error: "Unauthorized" }, { status: 401 });
  }
  const parsed = RecordReviewSchema.safeParse(await request.json());
  if (!parsed.success) {
    return Response.json(
      { error: "Invalid review", issues: parsed.error.issues },
      { status: 400 },
    );
  }
  return Response.json(await recordReview(parsed.data));
}
