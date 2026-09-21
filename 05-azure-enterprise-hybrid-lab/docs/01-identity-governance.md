# Phase 1 — Governance Foundation

Thiết lập nền tảng quản trị trước khi dựng bất kỳ resource nào: kiểm soát chi phí, phân cấp quản lý, chính sách bắt buộc, và cơ chế chống xóa nhầm.

## Nội dung triển khai

**Management Groups** — phân cấp quản lý theo mô hình doanh nghiệp (`Tenant Root Group` → `DTATech` → `DTATech-Platform` / `DTATech-Workloads`), subscription lab nằm dưới `DTATech-Workloads`.

![Management Groups](../screenshots/01.1-management-groups.png)

**Budget & Cost Alert** — thiết lập ngân sách và cảnh báo chi phí để kiểm soát subscription Azure for Students, tránh vượt credit ngoài ý muốn.

![Budget Alert](../screenshots/01.5-budget-alert.png)

**RBAC (Role-Based Access Control)** — thử nghiệm giới hạn quyền, xác nhận đúng hành vi Azure khi 1 thao tác bị chặn do thiếu quyền (custom role hoạt động đúng như thiết kế).

![RBAC error example](../screenshots/01.2-rbac-error-example.png)

**Resource Lock** — khóa resource quan trọng ở mức `CanNotDelete`, verify bằng cách thử xóa và bị chặn.

![Resource Lock](../screenshots/01.3-resource-lock.png)
![Resource Lock delete blocked](../screenshots/01.4-resource-lock-delete-blocked.png)

## Kỹ năng thể hiện
Management Groups hierarchy, Azure Policy, Custom RBAC role, Resource Lock, Cost Management & Budget alert — nền tảng governance theo chuẩn enterprise landing zone.
