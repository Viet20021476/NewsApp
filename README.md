# NewsApp
NewsApp là một ứng dụng di động được xây dựng theo mô hình MVVM, cho phép người dùng tìm kiếm và đọc các bài báo từ nhiều nguồn khác nhau. Ứng dụng bao gồm hai màn hình chính: FiltersViewController và NewsViewController.

## Mô tả
### FiltersViewController
FiltersViewController là màn hình đầu tiên mà người dùng sẽ thấy khi mở ứng dụng. Màn hình này cho phép người dùng chọn các tùy chọn sau:
- Từ khoá
- Danh mục
- Quốc gia
- Ngôn ngữ
- Ngày
- Sắp xếp
  
Khi người dùng đã chọn xong các tùy chọn và nhấn vào nút "Search", ứng dụng sẽ chuyển sang màn hình NewsViewController.

### NewsViewController
NewsViewController hiển thị danh sách các bài báo thỏa mãn các điều kiện đã đặt ra ở FiltersViewController. Màn hình này sử dụng UITableView để hiển thị danh sách bài báo, cho phép người dùng dễ dàng duyệt qua các bài viết.

## Yêu cầu kỹ thuật
Dưới đây là các yêu cầu kỹ thuật đã được hoàn thành trong dự án:
- Mô hình MVVM
- Hiển thị danh sách bài báo: NewsViewController sử dụng UITableView để hiển thị danh sách các bài báo.
- Multithreading: Sử dụng async/await.
- Request API: URLSession để request API và Codable protocol cho JSON parser.
